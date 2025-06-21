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

(declare-sort var2738 0)
(declare-sort var2453 0)
(declare-sort var3113 0)
(declare-sort var2901 0)
(declare-sort var1620 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2453-init () var2453)
(declare-fun var3113-init () var3113)
(declare-fun toCharArray/415275702 (String) (Array Int Int))
(declare-fun <init>/291801963 (var3113 (Array Int Int)) void)
(declare-fun <init>/-357973316 (var2453 var2901) void)
(declare-fun cast-from-var3113-to-var2901 (var3113) var2901)
(declare-fun getLineNumber/-1455344071 (var2453) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const null-var1620 var1620)
(declare-const var343 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var343 null-String)))
(define-const var1068 var2453 var2453-init) ; Statement: $r0 = new java.io.LineNumberReader 
(define-const var3630 var3113 var3113-init) ; Statement: $r1 = new java.io.CharArrayReader 
(assert true)
(define-const var2686 (Array Int Int) (toCharArray/415275702 var343)) ; Statement: $r3 = virtualinvoke r2.<java.lang.String: char[] toCharArray()>() 
(assert true)
;(assert (<init>/291801963 var3630 var2686)) ; Statement: specialinvoke $r1.<java.io.CharArrayReader: void <init>(char[])>($r3) 

(declare-const var3630!1 var3113)
(declare-const var2686!1 (Array Int Int))
(assert true)
;(assert (<init>/-357973316 var1068 (cast-from-var3113-to-var2901 var3630!1))) ; Statement: specialinvoke $r0.<java.io.LineNumberReader: void <init>(java.io.Reader)>($r1) 

(declare-const var1068!1 var2453)
(declare-const var3630!2 var3113)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2746 var1620) ; Statement: $r4 := @caughtexception 
(assert (not (= var2746 null-var1620)))
(assert true) ; Non Conditional
(assert true)
(define-const var1273 Int (getLineNumber/-1455344071 var1068!1)) ; Statement: $i0 = virtualinvoke $r0.<java.io.LineNumberReader: int getLineNumber()>() 
(define-const var2948 Int (cast-from-Int-to-Int var1273)) ; Statement: $l1 = (long) $i0 
 ; Statement: return $l1 
(check-sat)
; {var2453-init=([], java.io.LineNumberReader), var3113-init=([], java.io.CharArrayReader), toCharArray/415275702=([java.lang.String], char[]), <init>/291801963=([java.io.CharArrayReader, char[]], void), <init>/-357973316=([java.io.LineNumberReader, java.io.Reader], void), cast-from-var3113-to-var2901=([java.io.CharArrayReader], java.io.Reader), getLineNumber/-1455344071=([java.io.LineNumberReader], int), cast-from-Int-to-Int=([int], long)}
; {var343=r2, var2738=null_type, var2453=java.io.LineNumberReader, var1068=$r0, var3113=java.io.CharArrayReader, var3630=$r1, var2686=$r3, var2901=java.io.Reader, var1620=java.io.IOException, var2746=$r4, var1273=$i0, var2948=$l1}
; {r2=var343, null_type=var2738, java.io.LineNumberReader=var2453, $r0=var1068, java.io.CharArrayReader=var3113, $r1=var3630, $r3=var2686, java.io.Reader=var2901, java.io.IOException=var1620, $r4=var2746, $i0=var1273, $l1=var2948}
;seq <java.lang.String: char[] toCharArray()>
;cnt {"<java.lang.String: char[] toCharArray()>": 1}
;stmts r2 := @parameter0: java.lang.String;	$r0 = new java.io.LineNumberReader;	$r1 = new java.io.CharArrayReader;	$r3 = virtualinvoke r2.<java.lang.String: char[] toCharArray()>();	specialinvoke $r1.<java.io.CharArrayReader: void <init>(char[])>($r3);	specialinvoke $r0.<java.io.LineNumberReader: void <init>(java.io.Reader)>($r1);	$r4 := @caughtexception;	$i0 = virtualinvoke $r0.<java.io.LineNumberReader: int getLineNumber()>();	$l1 = (long) $i0;	return $l1
;block_num 3