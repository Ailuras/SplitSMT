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

(declare-sort var3489 0)
(declare-sort var180 0)
(declare-sort var1504 0)
(declare-sort var1264 0)
(declare-sort var1252 0)
(declare-sort var2347 0)
(declare-sort var1944 0)
(declare-sort var2750 0)
(declare-sort var471 0)
(declare-sort var531 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1504) void)
(declare-fun cast-from-var3489-to-var1504 (var3489) var1504)
(declare-fun getServiceInterface/-1311863806 (var180) String)
(declare-fun var1264_forName/-1763490630 (String) ClassObject)
(declare-fun clazz/105774719 (var3489) ClassObject)
(declare-fun getParameter/-1307325648 (var180 String) String)
(declare-fun var1252_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var1944_buildDefaultValidatorFactory/-984014425 () var2347)
(declare-fun var2347_getValidator/1021903253 (var2347) var2750)
(declare-fun validator/105774719 (var3489) var2750)
(declare-fun var471-init () var471)
(declare-fun <init>/-2175807 (var471) void)
(declare-fun cast-from-var471-to-var531 (var471) var531)
(declare-fun methodClassMap/105774719 (var3489) var531)
(declare-const null-var3489 var3489)
(declare-const null-var180 var180)
(declare-const var1721 var3489) ; Statement: r0 := @this: org.apache.dubbo.validation.support.jvalidation.JValidatorNew 
(assert (not (= var1721 null-var3489)))
(declare-const var3287 var180) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3287 null-var180)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var3489-to-var1504 var1721))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var1721!1 var3489)
(assert true)
(define-const var1476 String (getServiceInterface/-1311863806 var3287)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(define-const var1522 ClassObject (var1264_forName/-1763490630 var1476)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2) 
(declare-const var1721!2 var3489)
(assert (not (= var1721!2 null-var3489)))
(assert (= (clazz/105774719 var1721!2) var1522)) ; Statement: r0.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> = $r3 
(assert true)
(define-const var3377 String (getParameter/-1307325648 var3287 "jvalidationNew")) ; Statement: r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("jvalidationNew") 
(define-const var2403 Bool (var1252_isNotEmpty/-1251449450 var3377)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto r10 = staticinvoke <jakarta.validation.Validation: jakarta.validation.ValidatorFactory buildDefaultValidatorFactory()>() 
(assert (= (ite var2403 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3964 var2347 var1944_buildDefaultValidatorFactory/-984014425) ; Statement: r10 = staticinvoke <jakarta.validation.Validation: jakarta.validation.ValidatorFactory buildDefaultValidatorFactory()>() 
(assert true) ; Non Conditional
(define-const var3622 var2750 (var2347_getValidator/1021903253 var3964)) ; Statement: $r5 = interfaceinvoke r10.<jakarta.validation.ValidatorFactory: jakarta.validation.Validator getValidator()>() 
(declare-const var1721!3 var3489)
(assert (not (= var1721!3 null-var3489)))
(assert (= (validator/105774719 var1721!3) var3622)) ; Statement: r0.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: jakarta.validation.Validator validator> = $r5 
(define-const var768 var471 var471-init) ; Statement: $r6 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var768)) ; Statement: specialinvoke $r6.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var768!1 var471)
(declare-const var1721!4 var3489)
(assert (not (= var1721!4 null-var3489)))
(assert (= (methodClassMap/105774719 var1721!4) (cast-from-var471-to-var531 var768!1))) ; Statement: r0.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.util.Map methodClassMap> = $r6 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var3489-to-var1504=([org.apache.dubbo.validation.support.jvalidation.JValidatorNew], java.lang.Object), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), var1264_forName/-1763490630=([java.lang.String], java.lang.Class), clazz/105774719=([org.apache.dubbo.validation.support.jvalidation.JValidatorNew], java.lang.Class), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1252_isNotEmpty/-1251449450=([java.lang.String], boolean), var1944_buildDefaultValidatorFactory/-984014425=([], jakarta.validation.ValidatorFactory), var2347_getValidator/1021903253=([jakarta.validation.ValidatorFactory], jakarta.validation.Validator), validator/105774719=([org.apache.dubbo.validation.support.jvalidation.JValidatorNew], jakarta.validation.Validator), var471-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var471-to-var531=([java.util.concurrent.ConcurrentHashMap], java.util.Map), methodClassMap/105774719=([org.apache.dubbo.validation.support.jvalidation.JValidatorNew], java.util.Map)}
; {var3489=org.apache.dubbo.validation.support.jvalidation.JValidatorNew, var1721=r0, var180=org.apache.dubbo.common.URL, var3287=r1, var1504=java.lang.Object, var1476=$r2, var1264=org.apache.dubbo.common.utils.ReflectUtils, var1522=$r3, var3377=r4, var1252=org.apache.dubbo.common.utils.StringUtils, var2403=$z0, var2347=jakarta.validation.ValidatorFactory, var1944=jakarta.validation.Validation, var3964=r10, var2750=jakarta.validation.Validator, var3622=$r5, var471=java.util.concurrent.ConcurrentHashMap, var768=$r6, var531=java.util.Map}
; {org.apache.dubbo.validation.support.jvalidation.JValidatorNew=var3489, r0=var1721, org.apache.dubbo.common.URL=var180, r1=var3287, java.lang.Object=var1504, $r2=var1476, org.apache.dubbo.common.utils.ReflectUtils=var1264, $r3=var1522, r4=var3377, org.apache.dubbo.common.utils.StringUtils=var1252, $z0=var2403, jakarta.validation.ValidatorFactory=var2347, jakarta.validation.Validation=var1944, r10=var3964, jakarta.validation.Validator=var2750, $r5=var3622, java.util.concurrent.ConcurrentHashMap=var471, $r6=var768, java.util.Map=var531}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.validation.support.jvalidation.JValidatorNew;	r1 := @parameter0: org.apache.dubbo.common.URL;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2);	r0.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> = $r3;	r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("jvalidationNew");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4);	if $z0 == 0 goto r10 = staticinvoke <jakarta.validation.Validation: jakarta.validation.ValidatorFactory buildDefaultValidatorFactory()>();	r10 = staticinvoke <jakarta.validation.Validation: jakarta.validation.ValidatorFactory buildDefaultValidatorFactory()>();	$r5 = interfaceinvoke r10.<jakarta.validation.ValidatorFactory: jakarta.validation.Validator getValidator()>();	r0.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: jakarta.validation.Validator validator> = $r5;	$r6 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r6.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.util.Map methodClassMap> = $r6;	return
;block_num 3