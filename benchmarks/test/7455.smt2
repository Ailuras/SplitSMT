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

(declare-sort var1947 0)
(declare-sort var2220 0)
(declare-sort var3771 0)
(declare-sort var2119 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var3771) String)
(declare-fun cast-from-var2220-to-var3771 (var2220) var3771)
(declare-fun setMock/136566133 (var2119 String) void)
(declare-fun cast-from-var1947-to-var2119 (var1947) var2119)
(declare-const null-var1947 var1947)
(declare-const null-var2220 var2220)
(declare-const var3182 var1947) ; Statement: r1 := @this: com.alibaba.dubbo.config.ServiceConfig 
(assert (not (= var3182 null-var1947)))
(declare-const var3177 var2220) ; Statement: r0 := @parameter0: java.lang.Boolean 
(assert (not (= var3177 null-var2220)))
 ; Statement: if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert (not (= var3177 null-var2220))) ; Cond: r0 != null 
(define-const var1907 String (String_valueOf/-333372740 (cast-from-var2220-to-var3771 var3177))) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert true)
;(assert (setMock/136566133 (cast-from-var1947-to-var2119 var3182) var1907)) ; Statement: virtualinvoke r1.<com.alibaba.dubbo.config.ServiceConfig: void setMock(java.lang.String)>($r2) 

(declare-const var3182!1 var1947)
(declare-const var1907!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var2220-to-var3771=([java.lang.Boolean], java.lang.Object), setMock/136566133=([org.apache.dubbo.config.AbstractMethodConfig, java.lang.String], void), cast-from-var1947-to-var2119=([com.alibaba.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractMethodConfig)}
; {var1947=com.alibaba.dubbo.config.ServiceConfig, var3182=r1, var2220=java.lang.Boolean, var3177=r0, var3771=java.lang.Object, var1907=$r2, var2119=org.apache.dubbo.config.AbstractMethodConfig}
; {com.alibaba.dubbo.config.ServiceConfig=var1947, r1=var3182, java.lang.Boolean=var2220, r0=var3177, java.lang.Object=var3771, $r2=var1907, org.apache.dubbo.config.AbstractMethodConfig=var2119}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: com.alibaba.dubbo.config.ServiceConfig;	r0 := @parameter0: java.lang.Boolean;	if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	virtualinvoke r1.<com.alibaba.dubbo.config.ServiceConfig: void setMock(java.lang.String)>($r2);	return
;block_num 3