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

(declare-sort var3730 0)
(declare-sort var3223 0)
(declare-sort var1447 0)
(declare-sort var162 0)
(declare-sort var507 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3223-init () var3223)
(declare-fun var1447-init () var1447)
(declare-fun toCharArray/415275702 (String) (Array Int Int))
(declare-fun <init>/291801963 (var1447 (Array Int Int)) void)
(declare-fun <init>/-357973316 (var3223 var162) void)
(declare-fun cast-from-var1447-to-var162 (var1447) var162)
(declare-fun getLineNumber/-1455344071 (var3223) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const null-var507 var507)
(declare-const var2029 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2029 null-String)))
(define-const var818 var3223 var3223-init) ; Statement: $r0 = new java.io.LineNumberReader 
(define-const var3420 var1447 var1447-init) ; Statement: $r1 = new java.io.CharArrayReader 
(assert true)
(define-const var675 (Array Int Int) (toCharArray/415275702 var2029)) ; Statement: $r3 = virtualinvoke r2.<java.lang.String: char[] toCharArray()>() 
(assert true)
;(assert (<init>/291801963 var3420 var675)) ; Statement: specialinvoke $r1.<java.io.CharArrayReader: void <init>(char[])>($r3) 

(declare-const var3420!1 var1447)
(declare-const var675!1 (Array Int Int))
(assert true)
;(assert (<init>/-357973316 var818 (cast-from-var1447-to-var162 var3420!1))) ; Statement: specialinvoke $r0.<java.io.LineNumberReader: void <init>(java.io.Reader)>($r1) 

(declare-const var818!1 var3223)
(declare-const var3420!2 var1447)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2607 var507) ; Statement: $r4 := @caughtexception 
(assert (not (= var2607 null-var507)))
(assert true) ; Non Conditional
(assert true)
(define-const var1223 Int (getLineNumber/-1455344071 var818!1)) ; Statement: $i0 = virtualinvoke $r0.<java.io.LineNumberReader: int getLineNumber()>() 
(define-const var1539 Int (cast-from-Int-to-Int var1223)) ; Statement: $l1 = (long) $i0 
 ; Statement: return $l1 
(check-sat)
; {var3223-init=([], java.io.LineNumberReader), var1447-init=([], java.io.CharArrayReader), toCharArray/415275702=([java.lang.String], char[]), <init>/291801963=([java.io.CharArrayReader, char[]], void), <init>/-357973316=([java.io.LineNumberReader, java.io.Reader], void), cast-from-var1447-to-var162=([java.io.CharArrayReader], java.io.Reader), getLineNumber/-1455344071=([java.io.LineNumberReader], int), cast-from-Int-to-Int=([int], long)}
; {var2029=r2, var3730=null_type, var3223=java.io.LineNumberReader, var818=$r0, var1447=java.io.CharArrayReader, var3420=$r1, var675=$r3, var162=java.io.Reader, var507=java.io.IOException, var2607=$r4, var1223=$i0, var1539=$l1}
; {r2=var2029, null_type=var3730, java.io.LineNumberReader=var3223, $r0=var818, java.io.CharArrayReader=var1447, $r1=var3420, $r3=var675, java.io.Reader=var162, java.io.IOException=var507, $r4=var2607, $i0=var1223, $l1=var1539}
;seq <java.lang.String: char[] toCharArray()>
;cnt {"<java.lang.String: char[] toCharArray()>": 1}
;stmts r2 := @parameter0: java.lang.String;	$r0 = new java.io.LineNumberReader;	$r1 = new java.io.CharArrayReader;	$r3 = virtualinvoke r2.<java.lang.String: char[] toCharArray()>();	specialinvoke $r1.<java.io.CharArrayReader: void <init>(char[])>($r3);	specialinvoke $r0.<java.io.LineNumberReader: void <init>(java.io.Reader)>($r1);	$r4 := @caughtexception;	$i0 = virtualinvoke $r0.<java.io.LineNumberReader: int getLineNumber()>();	$l1 = (long) $i0;	return $l1
;block_num 3