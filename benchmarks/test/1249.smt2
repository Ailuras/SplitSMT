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

(declare-sort var164 0)
(declare-sort var3205 0)
(declare-sort var818 0)
(declare-sort var1453 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun remainSize/243653426 (var164) Int)
(declare-fun getBytes/-163691139 (String var818) (Array Int Int))
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var164 var164)
(declare-const null-String String)
(declare-const var1453-UTF_8 var818)
(declare-const var1553 var164) ; Statement: r0 := @this: org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter 
(assert (not (= var1553 null-var164)))
(declare-const var2977 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2977 null-String)))
(define-const var3985 Int (remainSize/243653426 var1553)) ; Statement: $l0 = r0.<org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter: long remainSize> 
(define-const var549 var818 var1453-UTF_8) ; Statement: $r2 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8> 
(assert true)
(define-const var3051 (Array Int Int) (getBytes/-163691139 var2977 var549)) ; Statement: $r3 = virtualinvoke r1.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r2) 
(define-const var3591 Int (getLength-Arr-Int-1 var3051)) ; Statement: $i1 = lengthof $r3 
(define-const var2293 Int (cast-from-Int-to-Int var3591)) ; Statement: $l2 = (long) $i1 
(define-const var853 Int (- var3985 var2293)) ; Statement: $l3 = $l0 - $l2 
(declare-const var1553!1 var164)
(assert (not (= var1553!1 null-var164)))
(assert (= (remainSize/243653426 var1553!1) var853)) ; Statement: r0.<org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter: long remainSize> = $l3 
(define-const var3677 Int (remainSize/243653426 var1553!1)) ; Statement: $l4 = r0.<org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter: long remainSize> 
(define-const var1241 Int (ite (> var3677 0) 1 (ite (< var3677 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
(define-const var2720 Int (cast-from-Int-to-Int var1241)) ; Statement: $i6 = (int) $b5 
 ; Statement: if $i6 >= 0 goto specialinvoke r0.<java.io.BufferedWriter: void write(java.lang.String)>(r1) 
(assert (not (>= var2720 0))) ; Negate: Cond: $i6 >= 0  
 ; Statement: return 
(check-sat)
; {remainSize/243653426=([org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter], long), getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), getLength-Arr-Int-1=([byte[]], int), cast-from-Int-to-Int=([int], long)}
; {var164=org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter, var1553=r0, var2977=r1, var3205=null_type, var3985=$l0, var818=java.nio.charset.Charset, var1453=java.nio.charset.StandardCharsets, var549=$r2, var3051=$r3, var3591=$i1, var2293=$l2, var853=$l3, var3677=$l4, var1241=$b5, var2720=$i6}
; {org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter=var164, r0=var1553, r1=var2977, null_type=var3205, $l0=var3985, java.nio.charset.Charset=var818, java.nio.charset.StandardCharsets=var1453, $r2=var549, $r3=var3051, $i1=var3591, $l2=var2293, $l3=var853, $l4=var3677, $b5=var1241, $i6=var2720}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter;	r1 := @parameter0: java.lang.String;	$l0 = r0.<org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter: long remainSize>;	$r2 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8>;	$r3 = virtualinvoke r1.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r2);	$i1 = lengthof $r3;	$l2 = (long) $i1;	$l3 = $l0 - $l2;	r0.<org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter: long remainSize> = $l3;	$l4 = r0.<org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter: long remainSize>;	$b5 = $l4 cmp 0L;	$i6 = (int) $b5;	if $i6 >= 0 goto specialinvoke r0.<java.io.BufferedWriter: void write(java.lang.String)>(r1);	return
;block_num 2