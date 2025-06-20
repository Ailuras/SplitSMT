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

(declare-sort var3506 0)
(declare-sort var3447 0)
(declare-sort var3179 0)
(declare-sort var3951 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var3179) String)
(declare-fun cast-from-var3447-to-var3179 (var3447) var3179)
(declare-fun setMock/136566133 (var3951 String) void)
(declare-fun cast-from-var3506-to-var3951 (var3506) var3951)
(declare-const null-var3506 var3506)
(declare-const null-var3447 var3447)
(declare-const var1752 var3506) ; Statement: r1 := @this: com.alibaba.dubbo.config.ProviderConfig 
(assert (not (= var1752 null-var3506)))
(declare-const var1932 var3447) ; Statement: r0 := @parameter0: java.lang.Boolean 
(assert (not (= var1932 null-var3447)))
 ; Statement: if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert (not (= var1932 null-var3447))) ; Cond: r0 != null 
(define-const var432 String (String_valueOf/-333372740 (cast-from-var3447-to-var3179 var1932))) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert true)
;(assert (setMock/136566133 (cast-from-var3506-to-var3951 var1752) var432)) ; Statement: virtualinvoke r1.<com.alibaba.dubbo.config.ProviderConfig: void setMock(java.lang.String)>($r2) 

(declare-const var1752!1 var3506)
(declare-const var432!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var3447-to-var3179=([java.lang.Boolean], java.lang.Object), setMock/136566133=([org.apache.dubbo.config.AbstractMethodConfig, java.lang.String], void), cast-from-var3506-to-var3951=([com.alibaba.dubbo.config.ProviderConfig], org.apache.dubbo.config.AbstractMethodConfig)}
; {var3506=com.alibaba.dubbo.config.ProviderConfig, var1752=r1, var3447=java.lang.Boolean, var1932=r0, var3179=java.lang.Object, var432=$r2, var3951=org.apache.dubbo.config.AbstractMethodConfig}
; {com.alibaba.dubbo.config.ProviderConfig=var3506, r1=var1752, java.lang.Boolean=var3447, r0=var1932, java.lang.Object=var3179, $r2=var432, org.apache.dubbo.config.AbstractMethodConfig=var3951}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: com.alibaba.dubbo.config.ProviderConfig;	r0 := @parameter0: java.lang.Boolean;	if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	virtualinvoke r1.<com.alibaba.dubbo.config.ProviderConfig: void setMock(java.lang.String)>($r2);	return
;block_num 3