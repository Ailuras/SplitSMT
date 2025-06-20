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

(declare-sort var2965 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mBuffer/-1735303467 (var2965) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-const null-var2965 var2965)
(declare-const null-Int Int)
(declare-const var1061 var2965) ; Statement: r0 := @this: org.apache.dubbo.common.io.UnsafeStringWriter 
(assert (not (= var1061 null-var2965)))
(declare-const var2136 Int) ; Statement: c0 := @parameter0: char 
(assert (not (= var2136 null-Int)))
(define-const var451 String (mBuffer/-1735303467 var1061)) ; Statement: $r1 = r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.StringBuilder mBuffer> 
(assert true)
;(assert (append/-1166366385 var451 var2136)) ; Statement: virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(c0) 
(declare-const var451!1 String)
(assert (str.prefixof var451 var451!1))
 ; Statement: return r0 
(check-sat)
; {mBuffer/-1735303467=([org.apache.dubbo.common.io.UnsafeStringWriter], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder)}
; {var2965=org.apache.dubbo.common.io.UnsafeStringWriter, var1061=r0, var2136=c0, var451=$r1}
; {org.apache.dubbo.common.io.UnsafeStringWriter=var2965, r0=var1061, c0=var2136, $r1=var451}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(char)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.io.UnsafeStringWriter;	c0 := @parameter0: char;	$r1 = r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.StringBuilder mBuffer>;	virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(c0);	return r0
;block_num 1