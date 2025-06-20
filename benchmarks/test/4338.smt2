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

(declare-sort var1191 0)
(declare-sort var3725 0)
(declare-sort var759 0)
(declare-sort var2436 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var759-init () var759)
(declare-fun <init>/630241661 (var759 var1191 String) void)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun read/-1845806611 (var2436 (Array Int Int)) Int)
(declare-fun cast-from-var759-to-var2436 (var759) var2436)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun close/1968604022 (var759) void)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1191 var1191)
(declare-const null-String String)
(declare-const var3090 var1191) ; Statement: r2 := @parameter0: java.io.InputStream 
(assert (not (= var3090 null-var1191)))
(declare-const var3646 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var3646 null-String)))
(define-const var3234 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3234)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3234!1 String)
(assert (= var3234!1 ""))
(define-const var1351 var759 var759-init) ; Statement: $r7 = new java.io.InputStreamReader 
(assert true)
;(assert (<init>/630241661 var1351 var3090 var3646)) ; Statement: specialinvoke $r7.<java.io.InputStreamReader: void <init>(java.io.InputStream,java.lang.String)>(r2, r3) 

(declare-const var1351!1 var759)
(declare-const var3090!1 var1191)
(declare-const var3646!1 String)
(define-const var2147 (Array Int Int) arr-Int-init) ; Statement: r4 = newarray (char)[1024] 
(assert true) ; Non Conditional
(assert true)
(define-const var1293 Int (read/-1845806611 (cast-from-var759-to-var2436 var1351!1) var2147)) ; Statement: $i0 = virtualinvoke $r7.<java.io.InputStreamReader: int read(char[])>(r4) 
(define-const var1693 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
 ; Statement: if $i0 == $i2 goto virtualinvoke $r7.<java.io.InputStreamReader: void close()>() 
(assert (= var1293 var1693)) ; Cond: $i0 == $i2 
(assert true)
;(assert (close/1968604022 var1351!1)) ; Statement: virtualinvoke $r7.<java.io.InputStreamReader: void close()>() 

(declare-const var1351!2 var759)
(assert true)
(define-const var2446 String (toString/-2075883882 var3234!1)) ; Statement: $r5 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r5 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var759-init=([], java.io.InputStreamReader), <init>/630241661=([java.io.InputStreamReader, java.io.InputStream, java.lang.String], void), arr-Int-init=([], char[]), read/-1845806611=([java.io.Reader, char[]], int), cast-from-var759-to-var2436=([java.io.InputStreamReader], java.io.Reader), cast-from-Int-to-Int=([int], int), close/1968604022=([java.io.InputStreamReader], void), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1191=java.io.InputStream, var3090=r2, var3646=r3, var3725=null_type, var3234=$r6, var759=java.io.InputStreamReader, var1351=$r7, var2147=r4, var2436=java.io.Reader, var1293=$i0, var1693=$i2, var2446=$r5}
; {java.io.InputStream=var1191, r2=var3090, r3=var3646, null_type=var3725, $r6=var3234, java.io.InputStreamReader=var759, $r7=var1351, r4=var2147, java.io.Reader=var2436, $i0=var1293, $i2=var1693, $r5=var2446}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @parameter0: java.io.InputStream;	r3 := @parameter1: java.lang.String;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r7 = new java.io.InputStreamReader;	specialinvoke $r7.<java.io.InputStreamReader: void <init>(java.io.InputStream,java.lang.String)>(r2, r3);	r4 = newarray (char)[1024];	$i0 = virtualinvoke $r7.<java.io.InputStreamReader: int read(char[])>(r4);	$i2 = (int) -1;	if $i0 == $i2 goto virtualinvoke $r7.<java.io.InputStreamReader: void close()>();	virtualinvoke $r7.<java.io.InputStreamReader: void close()>();	$r5 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r5
;block_num 3