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

(declare-sort var2268 0)
(declare-sort var413 0)
(declare-sort var3759 0)
(declare-sort var2794 0)
(declare-sort var3960 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun remainSize/243653426 (var2268) Int)
(declare-fun getBytes/-163691139 (String var3759) (Array Int Int))
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun write/654681022 (var3960 String) void)
(declare-fun cast-from-var2268-to-var3960 (var2268) var3960)
(declare-const null-var2268 var2268)
(declare-const null-String String)
(declare-const var2794-UTF_8 var3759)
(declare-const var982 var2268) ; Statement: r0 := @this: org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter 
(assert (not (= var982 null-var2268)))
(declare-const var358 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var358 null-String)))
(define-const var836 Int (remainSize/243653426 var982)) ; Statement: $l0 = r0.<org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter: long remainSize> 
(define-const var1669 var3759 var2794-UTF_8) ; Statement: $r2 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8> 
(assert true)
(define-const var3718 (Array Int Int) (getBytes/-163691139 var358 var1669)) ; Statement: $r3 = virtualinvoke r1.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r2) 
(define-const var1657 Int (getLength-Arr-Int-1 var3718)) ; Statement: $i1 = lengthof $r3 
(define-const var1598 Int (cast-from-Int-to-Int var1657)) ; Statement: $l2 = (long) $i1 
(define-const var3442 Int (- var836 var1598)) ; Statement: $l3 = $l0 - $l2 
(declare-const var982!1 var2268)
(assert (not (= var982!1 null-var2268)))
(assert (= (remainSize/243653426 var982!1) var3442)) ; Statement: r0.<org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter: long remainSize> = $l3 
(define-const var1407 Int (remainSize/243653426 var982!1)) ; Statement: $l4 = r0.<org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter: long remainSize> 
(define-const var2949 Int (ite (> var1407 0) 1 (ite (< var1407 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
(define-const var2092 Int (cast-from-Int-to-Int var2949)) ; Statement: $i6 = (int) $b5 
 ; Statement: if $i6 >= 0 goto specialinvoke r0.<java.io.BufferedWriter: void write(java.lang.String)>(r1) 
(assert (>= var2092 0)) ; Cond: $i6 >= 0 
(assert true)
;(assert (write/654681022 (cast-from-var2268-to-var3960 var982!1) var358)) ; Statement: specialinvoke r0.<java.io.BufferedWriter: void write(java.lang.String)>(r1) 

(declare-const var982!2 var2268)
(declare-const var358!1 String)
 ; Statement: return 
(check-sat)
; {remainSize/243653426=([org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter], long), getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), getLength-Arr-Int-1=([byte[]], int), cast-from-Int-to-Int=([int], long), write/654681022=([java.io.Writer, java.lang.String], void), cast-from-var2268-to-var3960=([org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter], java.io.Writer)}
; {var2268=org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter, var982=r0, var358=r1, var413=null_type, var836=$l0, var3759=java.nio.charset.Charset, var2794=java.nio.charset.StandardCharsets, var1669=$r2, var3718=$r3, var1657=$i1, var1598=$l2, var3442=$l3, var1407=$l4, var2949=$b5, var2092=$i6, var3960=java.io.Writer}
; {org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter=var2268, r0=var982, r1=var358, null_type=var413, $l0=var836, java.nio.charset.Charset=var3759, java.nio.charset.StandardCharsets=var2794, $r2=var1669, $r3=var3718, $i1=var1657, $l2=var1598, $l3=var3442, $l4=var1407, $b5=var2949, $i6=var2092, java.io.Writer=var3960}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter;	r1 := @parameter0: java.lang.String;	$l0 = r0.<org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter: long remainSize>;	$r2 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8>;	$r3 = virtualinvoke r1.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r2);	$i1 = lengthof $r3;	$l2 = (long) $i1;	$l3 = $l0 - $l2;	r0.<org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter: long remainSize> = $l3;	$l4 = r0.<org.apache.dubbo.common.cache.FileCacheStore$LimitedLengthBufferedWriter: long remainSize>;	$b5 = $l4 cmp 0L;	$i6 = (int) $b5;	if $i6 >= 0 goto specialinvoke r0.<java.io.BufferedWriter: void write(java.lang.String)>(r1);	specialinvoke r0.<java.io.BufferedWriter: void write(java.lang.String)>(r1);	return
;block_num 2