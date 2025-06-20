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

(declare-sort var3433 0)
(declare-sort var931 0)
(declare-sort var565 0)
(declare-sort var299 0)
(declare-sort var1922 0)
(declare-sort var3478 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var931 String) String)
(declare-fun var1922_isNotEmpty/-1251449450 (String) Bool)
(declare-fun setProperty/703705272 (var565 String String) var3478)
(declare-const null-var3433 var3433)
(declare-const null-var931 var931)
(declare-const null-var565 var565)
(declare-const null-String String)
(declare-const var455 var3433) ; Statement: r5 := @this: org.apache.dubbo.registry.nacos.NacosConnectionManager 
(assert (not (= var455 null-var3433)))
(declare-const var2847 var931) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2847 null-var931)))
(declare-const var3767 var565) ; Statement: r4 := @parameter1: java.util.Properties 
(assert (not (= var3767 null-var565)))
(declare-const var3938 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var3938 null-String)))
(declare-const var1398 String) ; Statement: r3 := @parameter3: java.lang.String 
(assert (not (= var1398 null-String)))
(assert true)
(define-const var2370 String (getParameter/-1307325648 var2847 var3938)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var599 Bool (var1922_isNotEmpty/-1251449450 var2370)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
(assert (not (= (ite var599 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
;(assert (setProperty/703705272 var3767 var3938 var2370)) ; Statement: virtualinvoke r4.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r2) 

(declare-const var3767!1 var565)
(declare-const var3938!1 String)
(declare-const var2370!1 String)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1922_isNotEmpty/-1251449450=([java.lang.String], boolean), setProperty/703705272=([java.util.Properties, java.lang.String, java.lang.String], java.lang.Object)}
; {var3433=org.apache.dubbo.registry.nacos.NacosConnectionManager, var455=r5, var931=org.apache.dubbo.common.URL, var2847=r0, var565=java.util.Properties, var3767=r4, var3938=r1, var299=null_type, var1398=r3, var2370=r2, var1922=org.apache.dubbo.common.utils.StringUtils, var599=$z0, var3478=java.lang.Object}
; {org.apache.dubbo.registry.nacos.NacosConnectionManager=var3433, r5=var455, org.apache.dubbo.common.URL=var931, r0=var2847, java.util.Properties=var565, r4=var3767, r1=var3938, null_type=var299, r3=var1398, r2=var2370, org.apache.dubbo.common.utils.StringUtils=var1922, $z0=var599, java.lang.Object=var3478}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r5 := @this: org.apache.dubbo.registry.nacos.NacosConnectionManager;	r0 := @parameter0: org.apache.dubbo.common.URL;	r4 := @parameter1: java.util.Properties;	r1 := @parameter2: java.lang.String;	r3 := @parameter3: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	virtualinvoke r4.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>(r1, r2);	goto [?= return];	return
;block_num 3