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

(declare-sort var2397 0)
(declare-sort var444 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var444) String)
(declare-const null-var2397 var2397)
(declare-const null-var444 var444)
(declare-const var1856 var2397) ; Statement: $r0 := @this: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__44 
(assert (not (= var1856 null-var2397)))
(declare-const var237 var444) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var237 null-var444)))
(define-const var911 String (String_valueOf/-333372740 var237)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1) 
 ; Statement: return $r2 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String)}
; {var2397=org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__44, var1856=$r0, var444=java.lang.Object, var237=$r1, var911=$r2}
; {org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__44=var2397, $r0=var1856, java.lang.Object=var444, $r1=var237, $r2=var911}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts $r0 := @this: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__44;	$r1 := @parameter0: java.lang.Object;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1);	return $r2
;block_num 1