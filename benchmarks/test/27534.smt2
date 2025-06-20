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

(declare-sort var2177 0)
(declare-sort var1471 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var1471) String)
(declare-const null-var2177 var2177)
(declare-const null-var1471 var1471)
(declare-const var2215 var2177) ; Statement: $r0 := @this: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__57 
(assert (not (= var2215 null-var2177)))
(declare-const var343 var1471) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var343 null-var1471)))
(define-const var18 String (String_valueOf/-333372740 var343)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1) 
 ; Statement: return $r2 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String)}
; {var2177=org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__57, var2215=$r0, var1471=java.lang.Object, var343=$r1, var18=$r2}
; {org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__57=var2177, $r0=var2215, java.lang.Object=var1471, $r1=var343, $r2=var18}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts $r0 := @this: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem$valueOf__57;	$r1 := @parameter0: java.lang.Object;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1);	return $r2
;block_num 1