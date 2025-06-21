(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2432 0)
(declare-sort var1266 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(declare-fun arr-var2432-init () (Array Int var2432))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var2432 (Int) var2432)
(declare-fun String_format/1339386452 (String (Array Int var2432)) String)
(declare-fun var1266-init () var1266)
(declare-fun <init>/-1057600344 (var1266 String) void)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const null-Int Int)
(declare-const null-__Array__Int__var2432__ (Array Int var2432))
(declare-const var3168 (Array Int Int)) ; Statement: r0 := @parameter0: byte[] 
(assert (not (= var3168 null-__Array__Int__Int__)))
(declare-const var3771 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var3771 null-Int)))
(declare-const var2094 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var2094 null-Int)))
(declare-const var1079 (Array Int Int)) ; Statement: r5 := @parameter3: char[] 
(assert (not (= var1079 null-__Array__Int__Int__)))
(declare-const var1536 Int) ; Statement: i32 := @parameter4: int 
(assert (not (= var1536 null-Int)))
(define-const var2925 Int (bv2nat (bvor ((_ int2bv 64) var3771) ((_ int2bv 64) var2094)))) ; Statement: $i5 = i0 | i1 
(define-const var2679 Int (getLength-Arr-Int-1 var3168)) ; Statement: $i2 = lengthof r0 
(define-const var1815 Int (- var2679 var3771)) ; Statement: $i3 = $i2 - i0 
(define-const var1851 Int (- var1815 var2094)) ; Statement: $i4 = $i3 - i1 
(define-const var496 Int (bv2nat (bvor ((_ int2bv 64) var2925) ((_ int2bv 64) var1851)))) ; Statement: $i6 = $i5 | $i4 
 ; Statement: if $i6 < 0 goto $r1 = newarray (java.lang.Object)[5] 
(assert (< var496 0)) ; Cond: $i6 < 0 
(define-const var2485 (Array Int var2432) arr-var2432-init) ; Statement: $r1 = newarray (java.lang.Object)[5] 
(define-const var2196 Int (getLength-Arr-Int-1 var3168)) ; Statement: $i7 = lengthof r0 
(define-const var3255 Int (Int_valueOf/-1371140006 var2196)) ; Statement: $r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i7) 
(declare-const var2485!1 (Array Int var2432))
(assert (not (= var2485!1 null-__Array__Int__var2432__)))
(assert (= (select var2485!1 0) (cast-from-Int-to-var2432 var3255))) ; Statement: $r1[0] = $r2 
(define-const var3922 Int (Int_valueOf/-1371140006 var3771)) ; Statement: $r3 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
(declare-const var2485!2 (Array Int var2432))
(assert (not (= var2485!2 null-__Array__Int__var2432__)))
(assert (= (select var2485!2 1) (cast-from-Int-to-var2432 var3922))) ; Statement: $r1[1] = $r3 
(define-const var1522 Int (Int_valueOf/-1371140006 var2094)) ; Statement: $r4 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i1) 
(declare-const var2485!3 (Array Int var2432))
(assert (not (= var2485!3 null-__Array__Int__var2432__)))
(assert (= (select var2485!3 2) (cast-from-Int-to-var2432 var1522))) ; Statement: $r1[2] = $r4 
(define-const var3133 Int (getLength-Arr-Int-1 var1079)) ; Statement: $i8 = lengthof r5 
(define-const var3451 Int (Int_valueOf/-1371140006 var3133)) ; Statement: $r6 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i8) 
(declare-const var2485!4 (Array Int var2432))
(assert (not (= var2485!4 null-__Array__Int__var2432__)))
(assert (= (select var2485!4 3) (cast-from-Int-to-var2432 var3451))) ; Statement: $r1[3] = $r6 
(define-const var1622 Int (Int_valueOf/-1371140006 var1536)) ; Statement: $r7 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i32) 
(declare-const var2485!5 (Array Int var2432))
(assert (not (= var2485!5 null-__Array__Int__var2432__)))
(assert (= (select var2485!5 4) (cast-from-Int-to-var2432 var1622))) ; Statement: $r1[4] = $r7 
(define-const var3114 String (String_format/1339386452 "buffer srcBytes.length=%d, srcIdx=%d, srcSize=%d, destChars.length=%d, destIdx=%d" var2485!5)) ; Statement: $r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("buffer srcBytes.length=%d, srcIdx=%d, srcSize=%d, destChars.length=%d, destIdx=%d", $r1) 
(define-const var1797 var1266 var1266-init) ; Statement: $r8 = new java.lang.ArrayIndexOutOfBoundsException 
(assert true)
;(assert (<init>/-1057600344 var1797 var3114)) ; Statement: specialinvoke $r8.<java.lang.ArrayIndexOutOfBoundsException: void <init>(java.lang.String)>($r12) 

(declare-const var1797!1 var1266)
(declare-const var3114!1 String)
 ; Statement: throw $r8 
(check-sat)
; {getLength-Arr-Int-1=([byte[]], int), arr-var2432-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var2432=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var1266-init=([], java.lang.ArrayIndexOutOfBoundsException), <init>/-1057600344=([java.lang.ArrayIndexOutOfBoundsException, java.lang.String], void)}
; {var3168=r0, var3771=i0, var2094=i1, var1079=r5, var1536=i32, var2925=$i5, var2679=$i2, var1815=$i3, var1851=$i4, var496=$i6, var2432=java.lang.Object, var2485=$r1, var2196=$i7, var3255=$r2, var3922=$r3, var1522=$r4, var3133=$i8, var3451=$r6, var1622=$r7, var3114=$r12, var1266=java.lang.ArrayIndexOutOfBoundsException, var1797=$r8}
; {r0=var3168, i0=var3771, i1=var2094, r5=var1079, i32=var1536, $i5=var2925, $i2=var2679, $i3=var1815, $i4=var1851, $i6=var496, java.lang.Object=var2432, $r1=var2485, $i7=var2196, $r2=var3255, $r3=var3922, $r4=var1522, $i8=var3133, $r6=var3451, $r7=var1622, $r12=var3114, java.lang.ArrayIndexOutOfBoundsException=var1266, $r8=var1797}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @parameter0: byte[];	i0 := @parameter1: int;	i1 := @parameter2: int;	r5 := @parameter3: char[];	i32 := @parameter4: int;	$i5 = i0 | i1;	$i2 = lengthof r0;	$i3 = $i2 - i0;	$i4 = $i3 - i1;	$i6 = $i5 | $i4;	if $i6 < 0 goto $r1 = newarray (java.lang.Object)[5];	$r1 = newarray (java.lang.Object)[5];	$i7 = lengthof r0;	$r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i7);	$r1[0] = $r2;	$r3 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	$r1[1] = $r3;	$r4 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i1);	$r1[2] = $r4;	$i8 = lengthof r5;	$r6 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i8);	$r1[3] = $r6;	$r7 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i32);	$r1[4] = $r7;	$r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("buffer srcBytes.length=%d, srcIdx=%d, srcSize=%d, destChars.length=%d, destIdx=%d", $r1);	$r8 = new java.lang.ArrayIndexOutOfBoundsException;	specialinvoke $r8.<java.lang.ArrayIndexOutOfBoundsException: void <init>(java.lang.String)>($r12);	throw $r8
;block_num 2