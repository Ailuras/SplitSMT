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

(declare-sort var499 0)
(declare-sort var3769 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var3769) String)
(declare-const null-var499 var499)
(declare-const null-var3769 var3769)
(declare-const var2198 var499) ; Statement: $r0 := @this: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__36 
(assert (not (= var2198 null-var499)))
(declare-const var843 var3769) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var843 null-var3769)))
(define-const var3198 String (String_valueOf/-333372740 var843)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1) 
 ; Statement: return $r2 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String)}
; {var499=org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__36, var2198=$r0, var3769=java.lang.Object, var843=$r1, var3198=$r2}
; {org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__36=var499, $r0=var2198, java.lang.Object=var3769, $r1=var843, $r2=var3198}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts $r0 := @this: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__36;	$r1 := @parameter0: java.lang.Object;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1);	return $r2
;block_num 1