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

(declare-sort var3395 0)
(declare-sort var332 0)
(declare-sort var2625 0)
(declare-sort var717 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var2625) String)
(declare-fun cast-from-var332-to-var2625 (var332) var2625)
(declare-fun setMock/136566133 (var717 String) void)
(declare-fun cast-from-var3395-to-var717 (var3395) var717)
(declare-const null-var3395 var3395)
(declare-const null-var332 var332)
(declare-const var2881 var3395) ; Statement: r1 := @this: com.alibaba.dubbo.config.ConsumerConfig 
(assert (not (= var2881 null-var3395)))
(declare-const var536 var332) ; Statement: r0 := @parameter0: java.lang.Boolean 
(assert (not (= var536 null-var332)))
 ; Statement: if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert (not (= var536 null-var332))) ; Cond: r0 != null 
(define-const var2424 String (String_valueOf/-333372740 (cast-from-var332-to-var2625 var536))) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert true)
;(assert (setMock/136566133 (cast-from-var3395-to-var717 var2881) var2424)) ; Statement: virtualinvoke r1.<com.alibaba.dubbo.config.ConsumerConfig: void setMock(java.lang.String)>($r2) 

(declare-const var2881!1 var3395)
(declare-const var2424!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var332-to-var2625=([java.lang.Boolean], java.lang.Object), setMock/136566133=([org.apache.dubbo.config.AbstractMethodConfig, java.lang.String], void), cast-from-var3395-to-var717=([com.alibaba.dubbo.config.ConsumerConfig], org.apache.dubbo.config.AbstractMethodConfig)}
; {var3395=com.alibaba.dubbo.config.ConsumerConfig, var2881=r1, var332=java.lang.Boolean, var536=r0, var2625=java.lang.Object, var2424=$r2, var717=org.apache.dubbo.config.AbstractMethodConfig}
; {com.alibaba.dubbo.config.ConsumerConfig=var3395, r1=var2881, java.lang.Boolean=var332, r0=var536, java.lang.Object=var2625, $r2=var2424, org.apache.dubbo.config.AbstractMethodConfig=var717}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: com.alibaba.dubbo.config.ConsumerConfig;	r0 := @parameter0: java.lang.Boolean;	if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	virtualinvoke r1.<com.alibaba.dubbo.config.ConsumerConfig: void setMock(java.lang.String)>($r2);	return
;block_num 3