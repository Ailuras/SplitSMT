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

(declare-sort var383 0)
(declare-sort var3560 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var3560) String)
(declare-const null-var383 var383)
(declare-const null-var3560 var3560)
(declare-const var1834 var383) ; Statement: $r0 := @this: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__69 
(assert (not (= var1834 null-var383)))
(declare-const var3590 var3560) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var3590 null-var3560)))
(define-const var3609 String (String_valueOf/-333372740 var3590)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1) 
 ; Statement: return $r2 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String)}
; {var383=org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__69, var1834=$r0, var3560=java.lang.Object, var3590=$r1, var3609=$r2}
; {org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__69=var383, $r0=var1834, java.lang.Object=var3560, $r1=var3590, $r2=var3609}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts $r0 := @this: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__69;	$r1 := @parameter0: java.lang.Object;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1);	return $r2
;block_num 1