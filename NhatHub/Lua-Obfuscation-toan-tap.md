# Lua/Luau Obfuscation Toàn Tập — Từ Cơ Bản Đến Nâng Cao

> Tài liệu tham khảo kỹ thuật, phục vụ nghiên cứu và phát triển obfuscator (áp dụng trực tiếp cho Noir Obfuscator).

---

## Phần 1: Tổng Quan

### Obfuscation là gì?
Obfuscation (làm rối mã nguồn) là quá trình biến đổi mã nguồn hoặc bytecode sao cho **hành vi thực thi giữ nguyên** nhưng **khó đọc, khó hiểu, khó phân tích ngược (reverse engineer)** đối với con người hoặc công cụ tự động (decompiler, deobfuscator).

Nguyên lý cốt lõi: `semantics(code) == semantics(obfuscated_code)` nhưng độ phức tạp phân tích (cyclomatic complexity, entropy, số bước suy luận cần thiết) tăng lên đáng kể.

### Obfuscation vs Encryption
| Tiêu chí | Obfuscation | Encryption |
|---|---|---|
| Mục tiêu | Gây khó khăn khi đọc/hiểu | Ngăn truy cập nội dung nếu không có khóa |
| Khả năng thực thi | Code vẫn chạy trực tiếp | Dữ liệu mã hóa không chạy được, cần giải mã trước |
| Đảo ngược | Luôn có thể (vì máy phải hiểu được để chạy) | Không thể nếu không có khóa đúng |
| Ứng dụng trong obfuscator | String/number encoding là **encoding có khóa runtime**, không phải encryption thật sự (khóa nằm ngay trong code) |

Điểm quan trọng: trong ngữ cảnh obfuscation Lua, "string encryption" thực chất là **encoding có thể đảo ngược tại runtime bằng khóa nhúng sẵn** — không phải encryption an toàn theo nghĩa mật mã học, vì khóa luôn đi kèm payload.

### Obfuscation vs Minify
| Tiêu chí | Minify | Obfuscation |
|---|---|---|
| Mục tiêu | Giảm kích thước file | Gây khó khăn phân tích |
| Kỹ thuật | Xóa khoảng trắng, comment, rút gọn tên | Biến đổi cấu trúc, mã hóa dữ liệu, chèn logic giả |
| Đảo ngược | Rất dễ (beautifier khôi phục gần như 100%) | Khó hơn nhiều, tùy tầng kỹ thuật |
| Hiệu năng | Không đổi hoặc nhanh hơn | Có thể chậm hơn (do logic giả, VM) |

### Giới hạn của Obfuscation
- **Không có obfuscator nào là bất khả xâm phạm.** Vì CPU/VM cuối cùng phải hiểu lệnh để thực thi, một reverse engineer đủ kiên nhẫn với thời gian đủ lớn luôn có thể phân tích được.
- Obfuscation làm **tăng chi phí thời gian/công sức** để phân tích, không loại bỏ khả năng phân tích.
- Luôn có đánh đổi giữa **độ khó phân tích** và **hiệu năng/kích thước file**.
- Obfuscation không thay thế cho các biện pháp bảo mật server-side (validation, licensing server, v.v.) khi cần bảo vệ logic nhạy cảm thực sự.

---

## Phần 2: Kỹ Thuật Cơ Bản

### Đổi tên biến / hàm / tham số (Identifier Renaming)
Thay tên có ý nghĩa bằng chuỗi vô nghĩa (`a`, `b`, `_0x1a2b`, hoặc ký tự Unicode giống nhau).

```lua
-- Trước
local playerHealth = 100
local function damagePlayer(amount)
    playerHealth = playerHealth - amount
end

-- Sau
local l1 = 100
local function l2(l3)
    l1 = l1 - l3
end
```
**Ưu điểm:** đơn giản, nhanh, không ảnh hưởng hiệu năng.
**Nhược điểm:** không chống được phân tích luồng dữ liệu (data flow analysis) — kẻ tấn công vẫn theo dõi được biến qua cách nó được dùng.
**Bảo mật:** thấp, nhưng là nền tảng bắt buộc cho mọi obfuscator.

### Loại bỏ khoảng trắng / gộp dòng / xóa comment
Thuộc nhóm minify, làm giảm khả năng đọc trực quan nhưng bị vô hiệu hóa gần như hoàn toàn bởi beautifier.

### Inline Function
Thay lời gọi hàm bằng nội dung hàm đó, phá vỡ cấu trúc module hóa dễ đọc.
```lua
-- Trước
local function add(a,b) return a+b end
print(add(1,2))
-- Sau (inline)
print((function(a,b) return a+b end)(1,2))
```

### Constant Folding (ngược — Constant Unfolding trong obfuscation)
Thay vì rút gọn `2+3` thành `5` (compiler tối ưu), obfuscator làm **ngược lại**: biến `5` thành `(2+3)` hoặc phức tạp hơn để giấu giá trị thật.

### Dead Code / Junk Code / Dummy Variables / Dummy Functions
Chèn mã không ảnh hưởng đến luồng thực thi thật (không bao giờ được gọi, hoặc kết quả không dùng tới) nhằm tăng nhiễu, tăng kích thước, gây rối phân tích tĩnh.

```lua
local __junk_1 = (function() local x = 42; return x * 2 end)()
if false then
    print("never runs")
end
```
**Nhược điểm:** tăng kích thước file, có thể bị loại bỏ bằng dead-code elimination nếu kẻ tấn công dùng công cụ tối ưu hóa.

---

## Phần 3: String Obfuscation

Ví dụ gốc dùng xuyên suốt: `local msg = "Hello"`

| Phương pháp | Cách hoạt động | Trước → Sau | Bảo mật |
|---|---|---|---|
| **string.char** | Lưu mã ASCII từng ký tự, ghép lại runtime | `"Hello"` → `string.char(72,101,108,108,111)` | Thấp — dễ decode bằng mắt |
| **Byte Array** | Lưu bảng số nguyên, decode bằng vòng lặp | `{72,101,108,108,111}` + loop `string.char` | Thấp-trung bình |
| **XOR** | XOR từng byte với khóa cố định/biến đổi | `string.char(72~0x5A, ...)` | Trung bình, phụ thuộc khóa có bị lộ không |
| **Caesar (shift)** | Dịch mã ASCII theo offset | `H`→`H+3` rồi decode `-3` | Thấp |
| **Base64** | Encode chuẩn base64 rồi decode runtime | `"SGVsbG8="` + decoder | Thấp — dễ nhận diện định dạng |
| **Hex** | Lưu dạng `\x48\x65...` | Ẩn ký tự khỏi string literal quét bằng mắt | Thấp |
| **Binary** | Lưu chuỗi nhị phân, decode bit-by-bit | Tăng độ dài đáng kể | Thấp, cồng kềnh |
| **Unicode escape** | `\u{...}` hoặc dùng ký tự nhìn giống nhau (homoglyph) | Gây rối trình soạn thảo/beautifier | Trung bình cho anti-beautify |
| **Reverse String** | Đảo ngược chuỗi, decode bằng revert runtime | `"olleH"` → reverse | Rất thấp, dễ đoán |
| **Split String** | Chia chuỗi thành nhiều phần rồi ghép | `"He".."ll".."o"` | Thấp |
| **Dynamic String** | Sinh chuỗi bằng phép toán runtime (không literal cố định) | Giá trị không tồn tại tĩnh trong bytecode | Trung bình-cao |
| **Runtime Decode** | Toàn bộ decode xảy ra khi chạy, không lưu plaintext bao giờ trong static analysis | Kết hợp với XOR/byte array | Trung bình-cao |
| **String Pool** | Tất cả string đưa vào 1 bảng chung, truy xuất qua index | `pool[7]` thay vì literal | Trung bình — gây khó traceback thủ công |
| **String Compression** | Nén (vd RLE, LZ) rồi giải nén runtime | Giảm kích thước + gây khó đọc | Trung bình |

**Kỹ thuật thực tế thường kết hợp nhiều lớp:** String Pool + XOR + Split + Runtime Decode để đạt độ khó phân tích cao mà vẫn giữ hiệu năng chấp nhận được. Đây chính là hướng Noir Obfuscator đang triển khai (XOR string encryption).

Ví dụ pipeline nhiều lớp:
```lua
-- Bước 1: XOR key = 0x2A, Bước 2: byte array, Bước 3: pool index
local __sp = {}
__sp[1] = (function()
    local b = {0x62,0x47,0x46,0x46,0x4B} -- "Hello" XOR 0x2A
    local s = {}
    for i=1,#b do s[i] = string.char(b[i] ~ 0x2A) end
    return table.concat(s)
end)()
print(__sp[1])
```

**Lưu ý quan trọng:** khóa XOR nằm ngay trong code → kẻ tấn công chỉ cần chạy sandbox/hook để lấy giá trị đã decode tại runtime (gọi là "runtime dump attack"). Đây là giới hạn cố hữu của mọi string obfuscation không dùng server-side key.

---

## Phần 4: Number Obfuscation

| Kỹ thuật | Ví dụ | Ghi chú |
|---|---|---|
| Cộng trừ nhân chia | `100` → `237 - 137` | Đơn giản, dễ tính ngược bằng eval |
| XOR | `100` → `(93 ~ 25)` | Cần bit32/Luau bitwise |
| Bit32 (shift/and/or) | `100` → `bit32.bor(96, 4)` | Phù hợp Lua 5.1/Roblox cũ |
| Floating Number trick | `100` → `math.floor(100.0001)` | Gây nhiễu định dạng |
| Random Expression | `100` → biểu thức ngẫu nhiên khác nhau mỗi lần build | Tăng entropy giữa các bản build |
| Runtime Calculation | Giá trị chỉ tồn tại sau khi hàm chạy, không có literal tĩnh | Chống static analysis tốt hơn |
| Boolean Arithmetic | `true and 100 or 0` dạng lồng ghép điều kiện giả | Kết hợp control-flow obfuscation |

```lua
-- Trước
local speed = 50
-- Sau (nhiều lớp)
local speed = (bit32.bxor(83, 33) + 0) - 0  -- = 50, ẩn qua XOR + phép toán thừa
```

---

## Phần 5: Control Flow Obfuscation

### Flattening (Control Flow Flattening)
Biến cấu trúc `if/while/for` lồng nhau thành một vòng lặp dispatcher điều khiển bằng biến trạng thái, phá vỡ hoàn toàn luồng đọc tuyến tính.

```lua
-- Trước
if a then
    step1()
else
    step2()
end
step3()

-- Sau (flattened)
local __state = 1
while __state ~= 0 do
    if __state == 1 then
        __state = a and 2 or 3
    elseif __state == 2 then
        step1(); __state = 4
    elseif __state == 3 then
        step2(); __state = 4
    elseif __state == 4 then
        step3(); __state = 0
    end
end
```

### State Machine / Dispatcher / Jump Table
Cùng bản chất với flattening: mọi block code trở thành "case" trong một bảng dispatch (`jumpTable[state]()`), gọi gián tiếp qua bảng thay vì nhảy trực tiếp — gây khó theo dõi thứ tự thực thi thật.

### Nested While / Fake Branch / Fake If / Infinite Loop giả
Chèn các nhánh điều kiện **không bao giờ đúng thực tế** nhưng biểu thức trông phức tạp, hoặc vòng lặp `while true do ... break ... end` giả tạo cảm giác vòng lặp vô hạn.

### Opaque Predicate (Vị từ mờ)
Biểu thức boolean mà giá trị **luôn cố định** (luôn true hoặc luôn false) nhưng không thể xác định điều đó chỉ bằng phân tích tĩnh đơn giản — cần suy luận toán học.

```lua
-- Luôn đúng, nhưng khó chứng minh tĩnh nếu x là biến runtime bất kỳ
local function opaquePredicateTrue(x)
    return (x*x - x) % 2 == 0  -- x(x-1) luôn chẵn với mọi số nguyên x
end

if opaquePredicateTrue(someRuntimeValue) then
    realCode()
else
    junkCode() -- không bao giờ chạy nhưng tồn tại để gây nhiễu
end
```
**Nguyên lý toán học:** `x(x-1)` là tích của 2 số nguyên liên tiếp, luôn chia hết cho 2 → biểu thức luôn `true`. Reverse engineer phải chứng minh toán học thay vì chỉ đọc code.

### Switch Simulation
Lua không có `switch` gốc — obfuscator giả lập bằng bảng hàm (`table dispatch`) để bắt chước switch-case, đồng thời làm mờ luồng điều khiển.

---

## Phần 6: Function Obfuscation

- **Function Wrapper**: bọc hàm gốc trong 1-2 lớp closure không cần thiết.
- **Closure**: dùng biến upvalue để giấu trạng thái, khó truy vết qua tham số.
- **Anonymous Function**: loại bỏ tên hàm, chỉ gọi qua biến hoặc trực tiếp IIFE.
- **Dynamic Function**: dựng hàm từ chuỗi bằng `load()`/`loadstring()` tại runtime — không tồn tại dạng tĩnh trong bytecode gốc.
- **Table Dispatch**: gọi hàm gián tiếp qua `funcTable[id](...)` thay vì gọi tên trực tiếp.
- **Metatable Dispatch**: dùng `__index`/`__call` để gián tiếp hóa lời gọi hàm, gây khó trace bằng debugger thông thường.
- **Function Encryption**: mã hóa toàn bộ chuỗi source của hàm, chỉ `load()` giải mã tại thời điểm gọi rồi hủy ngay sau đó (giảm thời gian dữ liệu "sạch" tồn tại trong bộ nhớ).

```lua
local encoded = "cmV0dXJuIDEwMA==" -- base64 của "return 100"
local decoded = base64_decode(encoded)
local fn = load(decoded)
print(fn())
```

---

## Phần 7: Table Obfuscation

- **Random Key**: key dạng chuỗi ngẫu nhiên thay vì tên có nghĩa (`t["_x9f2"]` thay vì `t.playerName`).
- **Numeric Key**: chuyển toàn bộ field sang index số, cần bảng ánh xạ riêng để biết ý nghĩa.
- **Mixed Key**: kết hợp số và chuỗi ngẫu nhiên trong cùng 1 table.
- **Hidden Table**: table được tạo và gán qua biến trung gian/upvalue, không xuất hiện trực tiếp ở scope ngoài.
- **Nested Table**: lồng nhiều cấp table để giấu cấu trúc dữ liệu thật.
- **Lazy Table**: dùng `__index` metamethod để field chỉ được tính/giải mã khi thực sự truy cập, tránh lộ toàn bộ dữ liệu cùng lúc khi dump bộ nhớ.

---

## Phần 8: VM Obfuscation

**Virtual Machine (VM) obfuscation** là kỹ thuật cao cấp nhất: thay vì chạy code Lua trực tiếp, obfuscator biên dịch code thành **bytecode tùy chỉnh** (custom instruction set do chính obfuscator định nghĩa), sau đó nhúng một **trình thông dịch (interpreter)** viết bằng Lua để đọc và thực thi bytecode đó tại runtime.

Các thành phần:
- **Bytecode**: chuỗi lệnh dạng số/nhị phân do VM tự định nghĩa (không phải Lua bytecode chuẩn).
- **Opcode**: mã số đại diện cho một lệnh (vd `0x01` = PUSH, `0x02` = ADD).
- **Register/Stack**: vùng lưu trữ tạm cho VM (dựa trên register-based như Lua 5.x hoặc stack-based).
- **Interpreter**: vòng lặp chính `while pc < #bytecode do ... end` đọc opcode và thực thi tương ứng.
- **Instruction Set**: tập hợp toàn bộ lệnh VM hỗ trợ (arithmetic, control flow, call, v.v.).
- **Decoder**: phần giải mã opcode → hành động cụ thể.
- **Virtual Execution**: quá trình thực thi hoàn toàn nằm trong interpreter tự viết, che giấu logic gốc khỏi Lua VM chuẩn.

```lua
-- Interpreter đơn giản hóa cực độ để minh họa nguyên lý
local bytecode = {1, 5, 1, 3, 2, 3} -- PUSH 5, PUSH 3, ADD
local stack = {}
local pc = 1
while pc <= #bytecode do
    local op = bytecode[pc]
    if op == 1 then -- PUSH
        table.insert(stack, bytecode[pc+1])
        pc = pc + 2
    elseif op == 2 then -- ADD
        local b, a = table.remove(stack), table.remove(stack)
        table.insert(stack, a+b)
        pc = pc + 1
    end
end
print(stack[1]) -- 8
```

**Ưu điểm:** mức độ bảo mật cao nhất trong các kỹ thuật obfuscation phần mềm thuần túy — kẻ tấn công phải reverse cả interpreter lẫn bytecode custom, không có công cụ decompiler sẵn nào hỗ trợ trực tiếp.
**Nhược điểm:**
- Hiệu năng giảm mạnh (thường 5–50 lần chậm hơn code gốc do overhead thông dịch).
- Độ phức tạp triển khai rất cao, dễ có bug logic.
- Kích thước file tăng đáng kể do interpreter + bytecode.
- Vẫn có thể bị phân tích nếu attacker kiên trì (không có gì bất khả xâm phạm).

---

## Phần 9: Bytecode

- **Lua Bytecode**: định dạng nhị phân do Lua chuẩn (PUC-Lua) sinh ra khi biên dịch, có thể dump bằng `string.dump()` và load lại bằng `load()`.
- **Luau Bytecode**: định dạng riêng của Roblox Luau, khác cấu trúc opcode so với Lua chuẩn, có version bytecode riêng.
- **Dump**: xuất bytecode từ hàm đã biên dịch (`string.dump(f)`).
- **Load**: nạp và biên dịch lại chuỗi bytecode/source thành hàm thực thi được (`load(bytes)`).
- **Chunk**: đơn vị mã nguồn/bytecode hoàn chỉnh (1 file/1 khối biên dịch).
- **Constant**: bảng hằng số (string, number) được lưu tách biệt trong bytecode, tham chiếu qua index.
- **Instruction**: từng lệnh máy ảo Lua (OP_ADD, OP_CALL, v.v.), có thể xem bằng công cụ disassembler.

**Lưu ý cho Noir Obfuscator:** vì dự án hoạt động ở tầng **AST (source-to-source)**, không phải tầng bytecode, nên obfuscation ở đây độc lập với cách Lua/Luau compiler sinh bytecode — đây là hướng tiếp cận phổ biến và linh hoạt nhất vì tương thích đa nền tảng (PUC-Lua, LuaJIT, Luau) mà không cần biết chi tiết bytecode nội bộ của từng runtime.

---

## Phần 10: Dynamic Runtime

- **`load()` / `loadstring()`**: biên dịch chuỗi thành hàm tại runtime — nền tảng của mọi kỹ thuật "runtime decode" (string encryption, function encryption, VM bootstrap).
- **Compile Runtime**: một phần code chỉ được biên dịch khi chương trình đang chạy, không tồn tại dạng tĩnh để phân tích trước.
- **Decode Runtime**: dữ liệu (string/number) chỉ được giải mã đúng lúc cần dùng, giảm thời gian "lộ" dữ liệu gốc trong bộ nhớ.
- **Environment (`_ENV`)**: bảng môi trường xác định phạm vi biến toàn cục — obfuscator có thể tạo `_ENV` giả để cô lập/gây nhiễu.
- **Sandbox**: môi trường thực thi giới hạn, dùng để kiểm tra an toàn khi `load()` code không tin cậy, hoặc để anti-tamper (phát hiện nếu chạy trong môi trường debug/hook).

---

## Phần 11: Anti Reverse Engineering

| Kỹ thuật | Nguyên lý | Hạn chế |
|---|---|---|
| **Anti Beautify** | Cấu trúc code (biểu thức/table/hàm lồng sâu, dòng siêu dài) khiến beautifier tự động format sai hoặc timeout | Beautifier hiện đại vẫn xử lý được phần lớn, chỉ làm chậm chứ không chặn |
| **Anti Decompiler** | Sinh cấu trúc AST/bytecode mà decompiler phổ biến không nhận diện đúng pattern (vd flattening phá vỡ giả định "cấu trúc có khối rõ ràng") | Decompiler chuyên dụng theo obfuscator cụ thể có thể vẫn giải được nếu pattern bị lộ |
| **Anti Tamper** | Kiểm tra checksum/hash của chính code lúc runtime, nếu bị sửa thì crash hoặc chạy sai có chủ đích | Có thể bị patch nếu tìm ra đúng điểm kiểm tra |
| **Anti Hook** | Phát hiện việc hàm chuẩn (`print`, `pcall`, v.v.) bị ghi đè bởi debugger/hook | Kẻ tấn công có thể hook ở tầng thấp hơn (C API) mà Lua script không thấy được |
| **Anti Debug** | Đo thời gian thực thi bất thường (debugger làm chậm), hoặc kiểm tra sự tồn tại của debug API | Dễ false positive, có thể bị bypass bằng patch timing |
| **Anti Dump** | Ngăn `string.dump()` hoặc memory dump lấy được bytecode/state sạch | Không thể chặn hoàn toàn nếu attacker kiểm soát toàn bộ runtime (vd client-side game) |
| **Anti Emulator** | Phát hiện đang chạy trong môi trường giả lập/sandbox phân tích thay vì runtime thật | Dựa trên heuristic, có thể lỗi thời khi môi trường giả lập cải tiến |
| **Integrity Check / Hash Check / CRC Check** | So sánh hash của đoạn code quan trọng với giá trị kỳ vọng, phát hiện chỉnh sửa | Hash/giá trị kỳ vọng vẫn nằm trong code, có thể bị tìm và patch đồng thời |

**Nguyên tắc chung:** mọi kỹ thuật anti-RE trên client-side (nhất là môi trường mà attacker kiểm soát hoàn toàn máy chạy, ví dụ game client) chỉ là **rào cản, không phải khóa tuyệt đối** — vì code cuối cùng vẫn phải chạy được trên máy của attacker.

---

## Phần 12: Anti Beautifier

Kỹ thuật khiến trình format code (Prettier-like) tạo ra output khó đọc hoặc lỗi:
- Biểu thức lồng sâu nhiều tầng (`((((a+b)*c)-d)/e)`).
- Hàm lồng nhau nhiều cấp (closures trong closures).
- Table lồng nhau sâu, mixed key.
- Control flow lồng sâu (nested if trong flattened dispatcher).
- Chuỗi cực dài (string pool gộp thành 1 literal khổng lồ).
- Biểu thức số học dài dằng dặc thay cho hằng số đơn giản.

Đây là các kỹ thuật **bổ trợ**, không phải lớp bảo mật độc lập — mục tiêu chính là làm chậm quá trình đọc thủ công của con người.

---

## Phần 13: Anti Decompiler

**Kỹ thuật thường dùng:** phá vỡ giả định cấu trúc mà decompiler dựa vào — ví dụ decompiler thường giả định `if/else` có khối rõ ràng, nhưng control flow flattening biến toàn bộ thành 1 vòng lặp dispatcher phẳng khiến decompiler không tái tạo được cấu trúc gốc, chỉ ra được dạng "state machine" khó đọc.

**Điểm mạnh:** hiệu quả cao với decompiler generic (không viết riêng cho obfuscator cụ thể).
**Điểm yếu:** decompiler chuyên dụng (viết riêng để đối phó 1 obfuscator cụ thể, dựa trên pattern signature) có thể vẫn giải ngược được, đặc biệt nếu obfuscator dùng pattern cố định không đổi giữa các lần build.

**Vì sao không có obfuscator nào chống decompile tuyệt đối:**
1. Lua/Luau runtime cuối cùng vẫn phải thực thi được lệnh → luôn tồn tại đường "đọc được" dù gián tiếp.
2. Chỉ cần chạy code trong sandbox có instrumentation (log mọi giá trị/lệnh thực thi), attacker lấy được "dynamic trace" phản ánh đúng hành vi, bất kể static structure bị làm rối đến đâu.
3. Con người + thời gian đủ lớn luôn thắng static obfuscation thuần túy — đây là giới hạn lý thuyết, không phải giới hạn kỹ thuật của riêng Lua.

---

## Phần 14: Randomization

Tăng entropy giữa các lần build để chống "signature-based deobfuscation" (nhận diện obfuscator qua pattern cố định):
- **Random Variable/Function/Constant naming**: tên khác nhau mỗi build.
- **Random Table structure**: thứ tự key, cấu trúc lồng khác nhau mỗi lần.
- **Random Control Flow**: dispatcher state ID, thứ tự case ngẫu nhiên mỗi build.
- **Random Expression**: cùng 1 hằng số nhưng biểu thức sinh ra khác nhau mỗi lần (vd `100` có thể là `50*2`, `99+1`, `bit32.bxor(...)`, tùy seed).

Đây là lý do thiết kế **multi-layer với seed ngẫu nhiên** (như Noir Obfuscator đã có 1-5 layers) quan trọng: nó vô hiệu hóa các công cụ deobfuscate "cứng" viết cho 1 signature cụ thể.

---

## Phần 15–16: AST Obfuscation & Parser

- **AST (Abstract Syntax Tree)**: cấu trúc cây biểu diễn code sau khi phân tích cú pháp, mỗi node là 1 thành phần ngôn ngữ (BinaryExpression, IfStatement, FunctionDeclaration...).
- **Tokenizer/Lexer**: quét source code thành chuỗi token (từ khóa, định danh, toán tử, literal).
- **Token**: đơn vị nhỏ nhất có ý nghĩa cú pháp (vd `local`, `=`, `"Hello"`, `+`).
- **Parser**: bộ phân tích cú pháp, ghép token thành AST theo ngữ pháp ngôn ngữ (thường dùng recursive-descent như Noir Obfuscator đã triển khai).
- **Node**: một phần tử AST cụ thể.
- **Visitor**: pattern duyệt cây AST (visit từng loại node, thường dùng cho mọi transform pass).
- **Transform**: bước biến đổi AST (rename, encode, flatten...) — đây chính là "pass" trong pipeline.
- **Code Generator (Emitter)**: bước cuối, chuyển AST đã biến đổi ngược lại thành chuỗi source code.

Quy trình tổng quát: `Source → Lexer → Tokens → Parser → AST → Transform Passes → AST mới → Emitter → Obfuscated Source`

---

## Phần 17: Viết Obfuscator — Từng Bước

1. **Đọc file**: nạp source code Lua/Luau dạng text.
2. **Tokenize**: lexer quét ký tự → sinh danh sách token, xử lý string/number/comment/keyword.
3. **Parse**: recursive-descent parser dựng AST theo ngữ pháp Lua (statement, expression, block).
4. **Tạo AST**: cây hoàn chỉnh biểu diễn toàn bộ chương trình.
5. **Biến đổi AST**: áp dụng lần lượt các pass (rename → string encode → number encode → control flow → dead code → junk code), mỗi pass tuân theo interface thuần `(ast, context) -> ast`.
6. **Sinh mã mới**: code generator duyệt AST đã biến đổi, in ra source Lua hợp lệ.
7. **Randomize**: áp dụng seed ngẫu nhiên cho tên biến, thứ tự, biểu thức số ở mỗi lần build.
8. **Xuất file**: ghi kết quả cuối cùng.

Đây chính xác là kiến trúc mà Noir Obfuscator đã xây dựng: lexer thủ công + recursive-descent parser + pipeline AST-based, không phụ thuộc thư viện parsing ngoài.

---

## Phần 18: Pipeline Chuyên Nghiệp

```
Source
  → Lexer/Tokenizer
  → Parser → AST
  → Pass: Rename (biến, hàm, tham số)
  → Pass: String Encode (XOR + Pool + Split)
  → Pass: Number Encode (bit32/arithmetic)
  → Pass: Constant Fold/Unfold
  → Pass: Control Flow (flatten + opaque predicate)
  → Pass: Dead Code Insertion
  → Pass: Junk Code Insertion
  → Pass: Randomize (seed cho toàn bộ pass trên)
  → Pass: Minify (xóa whitespace/comment còn sót)
  → Code Generator → Output
```

**Nguyên tắc thứ tự quan trọng:** rename nên chạy sớm (trước khi string/number encode) để tránh xung đột tên với biến tạm do các pass sau sinh ra; control flow flattening nên chạy sau khi mã hóa dữ liệu để dispatcher cũng được hưởng lợi từ obfuscation dữ liệu; minify luôn là bước cuối.

---

## Phần 19: Bảng Đánh Giá Kỹ Thuật

| Kỹ thuật | Độ khó triển khai | Mức bảo mật | Ảnh hưởng hiệu năng | Chống decompile | Phù hợp Lua/Luau |
|---|---|---|---|---|---|
| Rename định danh | Thấp | Thấp | Không | Không | ✅ Rất phù hợp |
| Minify | Thấp | Rất thấp | Không (có thể nhanh hơn) | Không | ✅ |
| String Encode (XOR+Pool) | Trung bình | Trung bình | Nhẹ | Một phần | ✅ |
| Number Encode | Thấp-Trung bình | Thấp-Trung bình | Rất nhẹ | Không | ✅ |
| Dead/Junk Code | Thấp | Thấp | Tăng kích thước | Một phần (gây nhiễu) | ✅ |
| Control Flow Flattening | Trung bình-Cao | Cao | Trung bình | Có | ✅ Rất hiệu quả với Lua |
| Opaque Predicate | Cao | Trung bình-Cao | Nhẹ | Có | ✅ |
| Function/Table Obfuscation | Trung bình | Trung bình | Nhẹ | Một phần | ✅ |
| VM Obfuscation | Rất cao | Rất cao | Cao (chậm 5-50x) | Rất tốt | ⚠️ Phù hợp nhưng tốn công lớn |
| Anti-Debug/Tamper | Cao | Trung bình (dễ lỗi thời) | Nhẹ-Trung bình | Gián tiếp | ⚠️ Cần cẩn trọng false positive |

---

## Phần 20: Kết Luận — Pipeline Cân Bằng Đề Xuất

Với mục tiêu **học tập, nghiên cứu, và cân bằng hiệu năng/bảo mật** (không cần VM obfuscation nặng nề trừ khi thực sự cần mức bảo vệ cao nhất), pipeline đề xuất:

1. **Rename** toàn bộ định danh (biến/hàm/tham số) — bắt buộc, chi phí thấp.
2. **String Obfuscation** nhiều lớp: String Pool + XOR + Split String + Runtime Decode.
3. **Number Obfuscation**: kết hợp arithmetic + bit32 + random expression theo seed.
4. **Control Flow Flattening** ở mức vừa phải (không lồng quá sâu để tránh hiệu năng giảm mạnh).
5. **Opaque Predicate** chèn có chọn lọc vào các điểm quyết định quan trọng, không lạm dụng toàn bộ code.
6. **Dead Code + Junk Code** ở mức độ vừa phải — cân bằng kích thước file với hiệu ứng gây nhiễu.
7. **Randomization** áp dụng seed khác nhau mỗi lần build để chống signature-based deobfuscation.
8. **Minify** ở bước cuối cùng.
9. **VM Obfuscation** chỉ nên là tùy chọn "Extreme" riêng biệt (như preset Noir Obfuscator đã có), dành cho trường hợp cần bảo vệ mức cao nhất và chấp nhận đánh đổi hiệu năng.

Đây chính là hướng đi phù hợp với kiến trúc hiện tại của Noir Obfuscator: pipeline pass-based `(ast, context) -> ast`, tích hợp qua mảng pipeline trong `obfuscator.service.js`, hỗ trợ nhiều tầng (1–5 layers) và preset "Extreme" — chỉ cần bổ sung dần các kỹ thuật ở Phần 5 (control flow nâng cao/opaque predicate) và Phần 8 (VM, nếu muốn mức bảo mật tối đa) mà không cần viết lại kiến trúc gốc.

**Ghi chú cuối:** không có kỹ thuật hay tổ hợp kỹ thuật nào đảm bảo "không thể bị reverse". Mục tiêu thực tế và khả thi là **tăng đáng kể thời gian/công sức cần thiết** để phân tích, đủ để nản lòng phần lớn kẻ tấn công không chuyên, trong khi vẫn giữ code chạy đúng và hiệu năng chấp nhận được.
