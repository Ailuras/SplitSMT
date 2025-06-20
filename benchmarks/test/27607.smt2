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

(declare-sort var137 0)
(declare-sort var3646 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var3646) String)
(declare-const null-var137 var137)
(declare-const null-var3646 var3646)
(declare-const var715 var137) ; Statement: $r0 := @this: org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule$valueOf__74 
(assert (not (= var715 null-var137)))
(declare-const var1961 var3646) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var1961 null-var3646)))
(define-const var3932 String (String_valueOf/-333372740 var1961)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1) 
 ; Statement: return $r2 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String)}
; {var137=org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule$valueOf__74, var715=$r0, var3646=java.lang.Object, var1961=$r1, var3932=$r2}
; {org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule$valueOf__74=var137, $r0=var715, java.lang.Object=var3646, $r1=var1961, $r2=var3932}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts $r0 := @this: org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule$valueOf__74;	$r1 := @parameter0: java.lang.Object;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1);	return $r2
;block_num 1