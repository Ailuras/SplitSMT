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

(declare-sort var401 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mBuffer/-1735303467 (var401) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun append/-1166366385 (String Int) String)
(declare-const null-var401 var401)
(declare-const null-Int Int)
(declare-const var2428 var401) ; Statement: r0 := @this: org.apache.dubbo.common.io.UnsafeStringWriter 
(assert (not (= var2428 null-var401)))
(declare-const var2049 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var2049 null-Int)))
(define-const var2707 String (mBuffer/-1735303467 var2428)) ; Statement: $r1 = r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.StringBuilder mBuffer> 
(define-const var1277 Int (cast-from-Int-to-Int var2049)) ; Statement: $c1 = (char) i0 
(assert true)
;(assert (append/-1166366385 var2707 var1277)) ; Statement: virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>($c1) 
(declare-const var2707!1 String)
(assert (str.prefixof var2707 var2707!1))
 ; Statement: return 
(check-sat)
; {mBuffer/-1735303467=([org.apache.dubbo.common.io.UnsafeStringWriter], java.lang.StringBuilder), cast-from-Int-to-Int=([int], char), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder)}
; {var401=org.apache.dubbo.common.io.UnsafeStringWriter, var2428=r0, var2049=i0, var2707=$r1, var1277=$c1}
; {org.apache.dubbo.common.io.UnsafeStringWriter=var401, r0=var2428, i0=var2049, $r1=var2707, $c1=var1277}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(char)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.io.UnsafeStringWriter;	i0 := @parameter0: int;	$r1 = r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.StringBuilder mBuffer>;	$c1 = (char) i0;	virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>($c1);	return
;block_num 1