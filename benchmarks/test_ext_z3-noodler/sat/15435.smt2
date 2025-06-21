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

(declare-sort var1724 0)
(declare-sort var2990 0)
(declare-sort var3400 0)
(declare-sort var3788 0)
(declare-sort var720 0)
(declare-sort var1711 0)
(declare-sort var1750 0)
(declare-sort var567 0)
(declare-sort var605 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1750!class ClassObject)
(declare-fun putPropertyIfAbsent/793784794 (var1724 var2990 var3400 String String) void)
(declare-fun var1711_of/1556381676 (ClassObject) var720)
(declare-fun getParameters/765734174 (var2990 var720) var567)
(declare-fun putAll/1634175762 (var3400 var567) void)
(declare-fun getUsername/657618160 (var2990) String)
(declare-fun var605_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getPassword/-1989005045 (var2990) String)
(declare-const null-var1724 var1724)
(declare-const null-var2990 var2990)
(declare-const null-var3400 var3400)
(declare-const null-NullType var3788)
(declare-const null-String String)
(declare-const var3428 var1724) ; Statement: r0 := @this: org.apache.dubbo.registry.nacos.NacosConnectionManager 
(assert (not (= var3428 null-var1724)))
(declare-const var1927 var2990) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1927 null-var2990)))
(declare-const var1338 var3400) ; Statement: r2 := @parameter1: java.util.Properties 
(assert (not (= var1338 null-var3400)))
(assert true)
;(assert (putPropertyIfAbsent/793784794 var3428 var1927 var1338 "com.alibaba.nacos.naming.log.filename" null-String)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.nacos.NacosConnectionManager: void putPropertyIfAbsent(org.apache.dubbo.common.URL,java.util.Properties,java.lang.String,java.lang.String)>(r1, r2, "com.alibaba.nacos.naming.log.filename", null) 

(declare-const var3428!1 var1724)
(declare-const var1927!1 var2990)
(declare-const var1338!1 var3400)
(declare-const var894 String)
(declare-const var116 var3788)
(define-const var2346 var720 (var1711_of/1556381676 var1750!class)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.StringConstantFieldValuePredicate: java.util.function.Predicate of(java.lang.Class)>(class "Lcom/alibaba/nacos/api/PropertyKeyConst;") 
(assert true)
(define-const var16 var567 (getParameters/765734174 var1927!1 var2346)) ; Statement: r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.util.Map getParameters(java.util.function.Predicate)>($r3) 
(assert true)
;(assert (putAll/1634175762 var1338!1 var16)) ; Statement: virtualinvoke r2.<java.util.Properties: void putAll(java.util.Map)>(r4) 

(declare-const var1338!2 var3400)
(declare-const var16!1 var567)
(assert true)
(define-const var1807 String (getUsername/657618160 var1927!1)) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getUsername()>() 
(define-const var2550 Bool (var605_isNotEmpty/-1251449450 var1807)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r5) 
 ; Statement: if $z0 == 0 goto $r6 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPassword()>() 
(assert (= (ite var2550 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var444 String (getPassword/-1989005045 var1927!1)) ; Statement: $r6 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPassword()>() 
(define-const var3981 Bool (var605_isNotEmpty/-1251449450 var444)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r6) 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var3981 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {putPropertyIfAbsent/793784794=([org.apache.dubbo.registry.nacos.NacosConnectionManager, org.apache.dubbo.common.URL, java.util.Properties, java.lang.String, java.lang.String], void), var1711_of/1556381676=([java.lang.Class], java.util.function.Predicate), getParameters/765734174=([org.apache.dubbo.common.URL, java.util.function.Predicate], java.util.Map), putAll/1634175762=([java.util.Properties, java.util.Map], void), getUsername/657618160=([org.apache.dubbo.common.URL], java.lang.String), var605_isNotEmpty/-1251449450=([java.lang.String], boolean), getPassword/-1989005045=([org.apache.dubbo.common.URL], java.lang.String)}
; {var1724=org.apache.dubbo.registry.nacos.NacosConnectionManager, var3428=r0, var2990=org.apache.dubbo.common.URL, var1927=r1, var3400=java.util.Properties, var1338=r2, var3788=null_type, var894="com.alibaba.nacos.naming.log.filename", var116=null, var720=java.util.function.Predicate, var1711=org.apache.dubbo.common.utils.StringConstantFieldValuePredicate, var1750=com.alibaba.nacos.api.PropertyKeyConst, var2346=$r3, var567=java.util.Map, var16=r4, var1807=$r5, var605=org.apache.dubbo.common.utils.StringUtils, var2550=$z0, var444=$r6, var3981=$z1}
; {org.apache.dubbo.registry.nacos.NacosConnectionManager=var1724, r0=var3428, org.apache.dubbo.common.URL=var2990, r1=var1927, java.util.Properties=var3400, r2=var1338, null_type=var3788, "com.alibaba.nacos.naming.log.filename"=var894, null=var116, java.util.function.Predicate=var720, org.apache.dubbo.common.utils.StringConstantFieldValuePredicate=var1711, com.alibaba.nacos.api.PropertyKeyConst=var1750, $r3=var2346, java.util.Map=var567, r4=var16, $r5=var1807, org.apache.dubbo.common.utils.StringUtils=var605, $z0=var2550, $r6=var444, $z1=var3981}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2}
;stmts r0 := @this: org.apache.dubbo.registry.nacos.NacosConnectionManager;	r1 := @parameter0: org.apache.dubbo.common.URL;	r2 := @parameter1: java.util.Properties;	specialinvoke r0.<org.apache.dubbo.registry.nacos.NacosConnectionManager: void putPropertyIfAbsent(org.apache.dubbo.common.URL,java.util.Properties,java.lang.String,java.lang.String)>(r1, r2, "com.alibaba.nacos.naming.log.filename", null);	$r3 = staticinvoke <org.apache.dubbo.common.utils.StringConstantFieldValuePredicate: java.util.function.Predicate of(java.lang.Class)>(class "Lcom/alibaba/nacos/api/PropertyKeyConst;");	r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.util.Map getParameters(java.util.function.Predicate)>($r3);	virtualinvoke r2.<java.util.Properties: void putAll(java.util.Map)>(r4);	$r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getUsername()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r5);	if $z0 == 0 goto $r6 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPassword()>();	$r6 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPassword()>();	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r6);	if $z1 == 0 goto return;	return
;block_num 3