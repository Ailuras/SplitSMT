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

(declare-sort var2369 0)
(declare-sort var2216 0)
(declare-sort var1976 0)
(declare-sort var438 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var1976) String)
(declare-fun cast-from-var2216-to-var1976 (var2216) var1976)
(declare-fun setMock/136566133 (var438 String) void)
(declare-fun cast-from-var2369-to-var438 (var2369) var438)
(declare-const null-var2369 var2369)
(declare-const null-var2216 var2216)
(declare-const var1144 var2369) ; Statement: r1 := @this: com.alibaba.dubbo.config.ReferenceConfig 
(assert (not (= var1144 null-var2369)))
(declare-const var542 var2216) ; Statement: r0 := @parameter0: java.lang.Boolean 
(assert (not (= var542 null-var2216)))
 ; Statement: if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert (not (= var542 null-var2216))) ; Cond: r0 != null 
(define-const var2119 String (String_valueOf/-333372740 (cast-from-var2216-to-var1976 var542))) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert true)
;(assert (setMock/136566133 (cast-from-var2369-to-var438 var1144) var2119)) ; Statement: virtualinvoke r1.<com.alibaba.dubbo.config.ReferenceConfig: void setMock(java.lang.String)>($r2) 

(declare-const var1144!1 var2369)
(declare-const var2119!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var2216-to-var1976=([java.lang.Boolean], java.lang.Object), setMock/136566133=([org.apache.dubbo.config.AbstractMethodConfig, java.lang.String], void), cast-from-var2369-to-var438=([com.alibaba.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractMethodConfig)}
; {var2369=com.alibaba.dubbo.config.ReferenceConfig, var1144=r1, var2216=java.lang.Boolean, var542=r0, var1976=java.lang.Object, var2119=$r2, var438=org.apache.dubbo.config.AbstractMethodConfig}
; {com.alibaba.dubbo.config.ReferenceConfig=var2369, r1=var1144, java.lang.Boolean=var2216, r0=var542, java.lang.Object=var1976, $r2=var2119, org.apache.dubbo.config.AbstractMethodConfig=var438}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: com.alibaba.dubbo.config.ReferenceConfig;	r0 := @parameter0: java.lang.Boolean;	if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	virtualinvoke r1.<com.alibaba.dubbo.config.ReferenceConfig: void setMock(java.lang.String)>($r2);	return
;block_num 3