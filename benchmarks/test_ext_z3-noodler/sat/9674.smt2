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

(declare-sort var3764 0)
(declare-sort var3335 0)
(declare-sort var3811 0)
(declare-sort var2309 0)
(declare-sort var3683 0)
(declare-sort var1062 0)
(declare-sort var3844 0)
(declare-sort var1614 0)
(declare-sort var381 0)
(declare-sort var538 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var3811) void)
(declare-fun cast-from-var3764-to-var3811 (var3764) var3811)
(declare-fun getServiceInterface/-1311863806 (var3335) String)
(declare-fun var2309_forName/-1763490630 (String) ClassObject)
(declare-fun clazz/1671654241 (var3764) ClassObject)
(declare-fun getParameter/-1307325648 (var3335 String) String)
(declare-fun var3683_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var3844_buildDefaultValidatorFactory/944983079 () var1062)
(declare-fun var1062_getValidator/130459605 (var1062) var1614)
(declare-fun validator/1671654241 (var3764) var1614)
(declare-fun var381-init () var381)
(declare-fun <init>/-2175807 (var381) void)
(declare-fun cast-from-var381-to-var538 (var381) var538)
(declare-fun methodClassMap/1671654241 (var3764) var538)
(declare-const null-var3764 var3764)
(declare-const null-var3335 var3335)
(declare-const var1216 var3764) ; Statement: r0 := @this: org.apache.dubbo.validation.support.jvalidation.JValidator 
(assert (not (= var1216 null-var3764)))
(declare-const var2447 var3335) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2447 null-var3335)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var3764-to-var3811 var1216))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var1216!1 var3764)
(assert true)
(define-const var958 String (getServiceInterface/-1311863806 var2447)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(define-const var2962 ClassObject (var2309_forName/-1763490630 var958)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2) 
(declare-const var1216!2 var3764)
(assert (not (= var1216!2 null-var3764)))
(assert (= (clazz/1671654241 var1216!2) var2962)) ; Statement: r0.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz> = $r3 
(assert true)
(define-const var2888 String (getParameter/-1307325648 var2447 "jvalidation")) ; Statement: r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("jvalidation") 
(define-const var2792 Bool (var3683_isNotEmpty/-1251449450 var2888)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto r10 = staticinvoke <javax.validation.Validation: javax.validation.ValidatorFactory buildDefaultValidatorFactory()>() 
(assert (= (ite var2792 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2869 var1062 var3844_buildDefaultValidatorFactory/944983079) ; Statement: r10 = staticinvoke <javax.validation.Validation: javax.validation.ValidatorFactory buildDefaultValidatorFactory()>() 
(assert true) ; Non Conditional
(define-const var2106 var1614 (var1062_getValidator/130459605 var2869)) ; Statement: $r5 = interfaceinvoke r10.<javax.validation.ValidatorFactory: javax.validation.Validator getValidator()>() 
(declare-const var1216!3 var3764)
(assert (not (= var1216!3 null-var3764)))
(assert (= (validator/1671654241 var1216!3) var2106)) ; Statement: r0.<org.apache.dubbo.validation.support.jvalidation.JValidator: javax.validation.Validator validator> = $r5 
(define-const var1679 var381 var381-init) ; Statement: $r6 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var1679)) ; Statement: specialinvoke $r6.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var1679!1 var381)
(declare-const var1216!4 var3764)
(assert (not (= var1216!4 null-var3764)))
(assert (= (methodClassMap/1671654241 var1216!4) (cast-from-var381-to-var538 var1679!1))) ; Statement: r0.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.util.Map methodClassMap> = $r6 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var3764-to-var3811=([org.apache.dubbo.validation.support.jvalidation.JValidator], java.lang.Object), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), var2309_forName/-1763490630=([java.lang.String], java.lang.Class), clazz/1671654241=([org.apache.dubbo.validation.support.jvalidation.JValidator], java.lang.Class), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3683_isNotEmpty/-1251449450=([java.lang.String], boolean), var3844_buildDefaultValidatorFactory/944983079=([], javax.validation.ValidatorFactory), var1062_getValidator/130459605=([javax.validation.ValidatorFactory], javax.validation.Validator), validator/1671654241=([org.apache.dubbo.validation.support.jvalidation.JValidator], javax.validation.Validator), var381-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var381-to-var538=([java.util.concurrent.ConcurrentHashMap], java.util.Map), methodClassMap/1671654241=([org.apache.dubbo.validation.support.jvalidation.JValidator], java.util.Map)}
; {var3764=org.apache.dubbo.validation.support.jvalidation.JValidator, var1216=r0, var3335=org.apache.dubbo.common.URL, var2447=r1, var3811=java.lang.Object, var958=$r2, var2309=org.apache.dubbo.common.utils.ReflectUtils, var2962=$r3, var2888=r4, var3683=org.apache.dubbo.common.utils.StringUtils, var2792=$z0, var1062=javax.validation.ValidatorFactory, var3844=javax.validation.Validation, var2869=r10, var1614=javax.validation.Validator, var2106=$r5, var381=java.util.concurrent.ConcurrentHashMap, var1679=$r6, var538=java.util.Map}
; {org.apache.dubbo.validation.support.jvalidation.JValidator=var3764, r0=var1216, org.apache.dubbo.common.URL=var3335, r1=var2447, java.lang.Object=var3811, $r2=var958, org.apache.dubbo.common.utils.ReflectUtils=var2309, $r3=var2962, r4=var2888, org.apache.dubbo.common.utils.StringUtils=var3683, $z0=var2792, javax.validation.ValidatorFactory=var1062, javax.validation.Validation=var3844, r10=var2869, javax.validation.Validator=var1614, $r5=var2106, java.util.concurrent.ConcurrentHashMap=var381, $r6=var1679, java.util.Map=var538}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.validation.support.jvalidation.JValidator;	r1 := @parameter0: org.apache.dubbo.common.URL;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2);	r0.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.lang.Class clazz> = $r3;	r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("jvalidation");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4);	if $z0 == 0 goto r10 = staticinvoke <javax.validation.Validation: javax.validation.ValidatorFactory buildDefaultValidatorFactory()>();	r10 = staticinvoke <javax.validation.Validation: javax.validation.ValidatorFactory buildDefaultValidatorFactory()>();	$r5 = interfaceinvoke r10.<javax.validation.ValidatorFactory: javax.validation.Validator getValidator()>();	r0.<org.apache.dubbo.validation.support.jvalidation.JValidator: javax.validation.Validator validator> = $r5;	$r6 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r6.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.validation.support.jvalidation.JValidator: java.util.Map methodClassMap> = $r6;	return
;block_num 3