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

(declare-sort var2407 0)
(declare-sort var2631 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var2631) String)
(declare-const null-var2407 var2407)
(declare-const null-var2631 var2631)
(declare-const var1961 var2407) ; Statement: $r0 := @this: org.apache.dubbo.rpc.cluster.router.tag.model.Tag$valueOf__98 
(assert (not (= var1961 null-var2407)))
(declare-const var2848 var2631) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var2848 null-var2631)))
(define-const var429 String (String_valueOf/-333372740 var2848)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1) 
 ; Statement: return $r2 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String)}
; {var2407=org.apache.dubbo.rpc.cluster.router.tag.model.Tag$valueOf__98, var1961=$r0, var2631=java.lang.Object, var2848=$r1, var429=$r2}
; {org.apache.dubbo.rpc.cluster.router.tag.model.Tag$valueOf__98=var2407, $r0=var1961, java.lang.Object=var2631, $r1=var2848, $r2=var429}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts $r0 := @this: org.apache.dubbo.rpc.cluster.router.tag.model.Tag$valueOf__98;	$r1 := @parameter0: java.lang.Object;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1);	return $r2
;block_num 1