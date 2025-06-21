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

(declare-sort var1549 0)
(declare-sort var434 0)
(declare-sort var772 0)
(declare-sort var1230 0)
(declare-sort var2181 0)
(declare-sort var2469 0)
(declare-sort var30 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2181!class ClassObject)
(declare-fun var1230_of/1556381676 (ClassObject) var772)
(declare-fun getParameters/765734174 (var1549 var772) var2469)
(declare-fun putAll/1634175762 (var434 var2469) void)
(declare-fun getUsername/657618160 (var1549) String)
(declare-fun var30_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getPassword/-1989005045 (var1549) String)
(declare-const null-var1549 var1549)
(declare-const null-var434 var434)
(declare-const var450 var1549) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var450 null-var1549)))
(declare-const var2533 var434) ; Statement: r3 := @parameter1: java.util.Properties 
(assert (not (= var2533 null-var434)))
(define-const var3945 var772 (var1230_of/1556381676 var2181!class)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.StringConstantFieldValuePredicate: java.util.function.Predicate of(java.lang.Class)>(class "Lcom/alibaba/nacos/api/PropertyKeyConst;") 
(assert true)
(define-const var1738 var2469 (getParameters/765734174 var450 var3945)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.util.Map getParameters(java.util.function.Predicate)>($r1) 
(assert true)
;(assert (putAll/1634175762 var2533 var1738)) ; Statement: virtualinvoke r3.<java.util.Properties: void putAll(java.util.Map)>(r2) 

(declare-const var2533!1 var434)
(declare-const var1738!1 var2469)
(assert true)
(define-const var1306 String (getUsername/657618160 var450)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getUsername()>() 
(define-const var2859 Bool (var30_isNotEmpty/-1251449450 var1306)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r4) 
 ; Statement: if $z0 == 0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPassword()>() 
(assert (= (ite var2859 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2861 String (getPassword/-1989005045 var450)) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPassword()>() 
(define-const var2662 Bool (var30_isNotEmpty/-1251449450 var2861)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r5) 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var2662 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {var1230_of/1556381676=([java.lang.Class], java.util.function.Predicate), getParameters/765734174=([org.apache.dubbo.common.URL, java.util.function.Predicate], java.util.Map), putAll/1634175762=([java.util.Properties, java.util.Map], void), getUsername/657618160=([org.apache.dubbo.common.URL], java.lang.String), var30_isNotEmpty/-1251449450=([java.lang.String], boolean), getPassword/-1989005045=([org.apache.dubbo.common.URL], java.lang.String)}
; {var1549=org.apache.dubbo.common.URL, var450=r0, var434=java.util.Properties, var2533=r3, var772=java.util.function.Predicate, var1230=org.apache.dubbo.common.utils.StringConstantFieldValuePredicate, var2181=com.alibaba.nacos.api.PropertyKeyConst, var3945=$r1, var2469=java.util.Map, var1738=r2, var1306=$r4, var30=org.apache.dubbo.common.utils.StringUtils, var2859=$z0, var2861=$r5, var2662=$z1}
; {org.apache.dubbo.common.URL=var1549, r0=var450, java.util.Properties=var434, r3=var2533, java.util.function.Predicate=var772, org.apache.dubbo.common.utils.StringConstantFieldValuePredicate=var1230, com.alibaba.nacos.api.PropertyKeyConst=var2181, $r1=var3945, java.util.Map=var2469, r2=var1738, $r4=var1306, org.apache.dubbo.common.utils.StringUtils=var30, $z0=var2859, $r5=var2861, $z1=var2662}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r3 := @parameter1: java.util.Properties;	$r1 = staticinvoke <org.apache.dubbo.common.utils.StringConstantFieldValuePredicate: java.util.function.Predicate of(java.lang.Class)>(class "Lcom/alibaba/nacos/api/PropertyKeyConst;");	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.util.Map getParameters(java.util.function.Predicate)>($r1);	virtualinvoke r3.<java.util.Properties: void putAll(java.util.Map)>(r2);	$r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getUsername()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r4);	if $z0 == 0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPassword()>();	$r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPassword()>();	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r5);	if $z1 == 0 goto return;	return
;block_num 3