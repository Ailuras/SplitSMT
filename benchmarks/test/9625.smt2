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

(declare-sort var930 0)
(declare-sort var2908 0)
(declare-sort var3861 0)
(declare-sort var2472 0)
(declare-sort var1211 0)
(declare-sort var1226 0)
(declare-sort var3868 0)
(declare-sort var845 0)
(declare-sort var633 0)
(declare-sort var949 0)
(declare-sort var1868 0)
(declare-sort var1792 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var3861) void)
(declare-fun cast-from-var930-to-var3861 (var930) var3861)
(declare-fun getServiceInterface/-1311863806 (var2908) String)
(declare-fun var2472_forName/-1763490630 (String) ClassObject)
(declare-fun clazz/1671654241 (var930) ClassObject)
(declare-fun getParameter/-1307325648 (var2908 String) String)
(declare-fun var1211_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var3868_byProvider/-309100533 (ClassObject) var1226)
(declare-fun var1226_configure/1162212078 (var1226) var845)
(declare-fun var845_buildValidatorFactory/-1000152483 (var845) var633)
(declare-fun var633_getValidator/130459605 (var633) var949)
(declare-fun validator/1671654241 (var930) var949)
(declare-fun var1868-init () var1868)
(declare-fun <init>/-2175807 (var1868) void)
(declare-fun cast-from-var1868-to-var1792 (var1868) var1792)
(declare-fun methodClassMap/1671654241 (var930) var1792)
(declare-const null-var930 var930)
(declare-const null-var2908 var2908)
(declare-const var3274 var930) ; Statement: r0 := @this: org.apache.dubbo.validation.support.jvalidation.JValidator 
(assert (not (= var3274 null-var930)))
(declare-const var2375 var2908) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2375 null-var2908)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var930-to-var3861 var3274))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var3274!1 var930)
(assert true)
(define-const var1487 String (getServiceInterface/-1311863806 var2375)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(define-const var3091 ClassObject (var2472_forName/-1763490630 var1487)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2) 
(declare-const var3274!2 var930)
(assert (not (= var3274!2 null-var930)))
(assert (= (clazz/1671654241 var3274!2) var3091)) ; Statement: r0.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz> = $r3 
(assert true)
(define-const var1196 String (getParameter/-1307325648 var2375 "jvalidation")) ; Statement: r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("jvalidation") 
(define-const var3125 Bool (var1211_isNotEmpty/-1251449450 var1196)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto r10 = staticinvoke <javax.validation.Validation: javax.validation.ValidatorFactory buildDefaultValidatorFactory()>() 
(assert (not (= (ite var3125 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2363 ClassObject (var2472_forName/-1763490630 var1196)) ; Statement: $r7 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r4) 
(define-const var2669 var1226 (var3868_byProvider/-309100533 var2363)) ; Statement: $r8 = staticinvoke <javax.validation.Validation: javax.validation.bootstrap.ProviderSpecificBootstrap byProvider(java.lang.Class)>($r7) 
(define-const var263 var845 (var1226_configure/1162212078 var2669)) ; Statement: $r9 = interfaceinvoke $r8.<javax.validation.bootstrap.ProviderSpecificBootstrap: javax.validation.Configuration configure()>() 
(define-const var3537 var633 (var845_buildValidatorFactory/-1000152483 var263)) ; Statement: r10 = interfaceinvoke $r9.<javax.validation.Configuration: javax.validation.ValidatorFactory buildValidatorFactory()>() 
 ; Statement: goto [?= $r5 = interfaceinvoke r10.<javax.validation.ValidatorFactory: javax.validation.Validator getValidator()>()] 
(assert true) ; Non Conditional
(define-const var3148 var949 (var633_getValidator/130459605 var3537)) ; Statement: $r5 = interfaceinvoke r10.<javax.validation.ValidatorFactory: javax.validation.Validator getValidator()>() 
(declare-const var3274!3 var930)
(assert (not (= var3274!3 null-var930)))
(assert (= (validator/1671654241 var3274!3) var3148)) ; Statement: r0.<org.apache.dubbo.validation.support.jvalidation.JValidator: javax.validation.Validator validator> = $r5 
(define-const var2931 var1868 var1868-init) ; Statement: $r6 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var2931)) ; Statement: specialinvoke $r6.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var2931!1 var1868)
(declare-const var3274!4 var930)
(assert (not (= var3274!4 null-var930)))
(assert (= (methodClassMap/1671654241 var3274!4) (cast-from-var1868-to-var1792 var2931!1))) ; Statement: r0.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.util.Map methodClassMap> = $r6 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var930-to-var3861=([org.apache.dubbo.validation.support.jvalidation.JValidator], java.lang.Object), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), var2472_forName/-1763490630=([java.lang.String], java.lang.Class), clazz/1671654241=([org.apache.dubbo.validation.support.jvalidation.JValidator], java.lang.Class), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1211_isNotEmpty/-1251449450=([java.lang.String], boolean), var3868_byProvider/-309100533=([java.lang.Class], javax.validation.bootstrap.ProviderSpecificBootstrap), var1226_configure/1162212078=([javax.validation.bootstrap.ProviderSpecificBootstrap], javax.validation.Configuration), var845_buildValidatorFactory/-1000152483=([javax.validation.Configuration], javax.validation.ValidatorFactory), var633_getValidator/130459605=([javax.validation.ValidatorFactory], javax.validation.Validator), validator/1671654241=([org.apache.dubbo.validation.support.jvalidation.JValidator], javax.validation.Validator), var1868-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var1868-to-var1792=([java.util.concurrent.ConcurrentHashMap], java.util.Map), methodClassMap/1671654241=([org.apache.dubbo.validation.support.jvalidation.JValidator], java.util.Map)}
; {var930=org.apache.dubbo.validation.support.jvalidation.JValidator, var3274=r0, var2908=org.apache.dubbo.common.URL, var2375=r1, var3861=java.lang.Object, var1487=$r2, var2472=org.apache.dubbo.common.utils.ReflectUtils, var3091=$r3, var1196=r4, var1211=org.apache.dubbo.common.utils.StringUtils, var3125=$z0, var2363=$r7, var1226=javax.validation.bootstrap.ProviderSpecificBootstrap, var3868=javax.validation.Validation, var2669=$r8, var845=javax.validation.Configuration, var263=$r9, var633=javax.validation.ValidatorFactory, var3537=r10, var949=javax.validation.Validator, var3148=$r5, var1868=java.util.concurrent.ConcurrentHashMap, var2931=$r6, var1792=java.util.Map}
; {org.apache.dubbo.validation.support.jvalidation.JValidator=var930, r0=var3274, org.apache.dubbo.common.URL=var2908, r1=var2375, java.lang.Object=var3861, $r2=var1487, org.apache.dubbo.common.utils.ReflectUtils=var2472, $r3=var3091, r4=var1196, org.apache.dubbo.common.utils.StringUtils=var1211, $z0=var3125, $r7=var2363, javax.validation.bootstrap.ProviderSpecificBootstrap=var1226, javax.validation.Validation=var3868, $r8=var2669, javax.validation.Configuration=var845, $r9=var263, javax.validation.ValidatorFactory=var633, r10=var3537, javax.validation.Validator=var949, $r5=var3148, java.util.concurrent.ConcurrentHashMap=var1868, $r6=var2931, java.util.Map=var1792}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.validation.support.jvalidation.JValidator;	r1 := @parameter0: org.apache.dubbo.common.URL;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2);	r0.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz> = $r3;	r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("jvalidation");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4);	if $z0 == 0 goto r10 = staticinvoke <javax.validation.Validation: javax.validation.ValidatorFactory buildDefaultValidatorFactory()>();	$r7 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r4);	$r8 = staticinvoke <javax.validation.Validation: javax.validation.bootstrap.ProviderSpecificBootstrap byProvider(java.lang.Class)>($r7);	$r9 = interfaceinvoke $r8.<javax.validation.bootstrap.ProviderSpecificBootstrap: javax.validation.Configuration configure()>();	r10 = interfaceinvoke $r9.<javax.validation.Configuration: javax.validation.ValidatorFactory buildValidatorFactory()>();	goto [?= $r5 = interfaceinvoke r10.<javax.validation.ValidatorFactory: javax.validation.Validator getValidator()>()];	$r5 = interfaceinvoke r10.<javax.validation.ValidatorFactory: javax.validation.Validator getValidator()>();	r0.<org.apache.dubbo.validation.support.jvalidation.JValidator: javax.validation.Validator validator> = $r5;	$r6 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r6.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.util.Map methodClassMap> = $r6;	return
;block_num 3