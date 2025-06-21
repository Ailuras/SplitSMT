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

(declare-sort var2612 0)
(declare-sort var3094 0)
(declare-sort var1551 0)
(declare-sort var1429 0)
(declare-sort var1178 0)
(declare-sort var2728 0)
(declare-sort var2492 0)
(declare-sort var3617 0)
(declare-sort var2017 0)
(declare-sort var1416 0)
(declare-sort var3877 0)
(declare-sort var1075 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1551) void)
(declare-fun cast-from-var2612-to-var1551 (var2612) var1551)
(declare-fun getServiceInterface/-1311863806 (var3094) String)
(declare-fun var1429_forName/-1763490630 (String) ClassObject)
(declare-fun clazz/105774719 (var2612) ClassObject)
(declare-fun getParameter/-1307325648 (var3094 String) String)
(declare-fun var1178_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var2492_byProvider/2067682699 (ClassObject) var2728)
(declare-fun var2728_configure/991606694 (var2728) var3617)
(declare-fun var3617_buildValidatorFactory/-1780751643 (var3617) var2017)
(declare-fun var2017_getValidator/1021903253 (var2017) var1416)
(declare-fun validator/105774719 (var2612) var1416)
(declare-fun var3877-init () var3877)
(declare-fun <init>/-2175807 (var3877) void)
(declare-fun cast-from-var3877-to-var1075 (var3877) var1075)
(declare-fun methodClassMap/105774719 (var2612) var1075)
(declare-const null-var2612 var2612)
(declare-const null-var3094 var3094)
(declare-const var1062 var2612) ; Statement: r0 := @this: org.apache.dubbo.validation.support.jvalidation.JValidatorNew 
(assert (not (= var1062 null-var2612)))
(declare-const var843 var3094) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var843 null-var3094)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2612-to-var1551 var1062))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var1062!1 var2612)
(assert true)
(define-const var3155 String (getServiceInterface/-1311863806 var843)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(define-const var1334 ClassObject (var1429_forName/-1763490630 var3155)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2) 
(declare-const var1062!2 var2612)
(assert (not (= var1062!2 null-var2612)))
(assert (= (clazz/105774719 var1062!2) var1334)) ; Statement: r0.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> = $r3 
(assert true)
(define-const var2607 String (getParameter/-1307325648 var843 "jvalidationNew")) ; Statement: r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("jvalidationNew") 
(define-const var1370 Bool (var1178_isNotEmpty/-1251449450 var2607)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto r10 = staticinvoke <jakarta.validation.Validation: jakarta.validation.ValidatorFactory buildDefaultValidatorFactory()>() 
(assert (not (= (ite var1370 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var622 ClassObject (var1429_forName/-1763490630 var2607)) ; Statement: $r7 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r4) 
(define-const var3833 var2728 (var2492_byProvider/2067682699 var622)) ; Statement: $r8 = staticinvoke <jakarta.validation.Validation: jakarta.validation.bootstrap.ProviderSpecificBootstrap byProvider(java.lang.Class)>($r7) 
(define-const var1567 var3617 (var2728_configure/991606694 var3833)) ; Statement: $r9 = interfaceinvoke $r8.<jakarta.validation.bootstrap.ProviderSpecificBootstrap: jakarta.validation.Configuration configure()>() 
(define-const var291 var2017 (var3617_buildValidatorFactory/-1780751643 var1567)) ; Statement: r10 = interfaceinvoke $r9.<jakarta.validation.Configuration: jakarta.validation.ValidatorFactory buildValidatorFactory()>() 
 ; Statement: goto [?= $r5 = interfaceinvoke r10.<jakarta.validation.ValidatorFactory: jakarta.validation.Validator getValidator()>()] 
(assert true) ; Non Conditional
(define-const var757 var1416 (var2017_getValidator/1021903253 var291)) ; Statement: $r5 = interfaceinvoke r10.<jakarta.validation.ValidatorFactory: jakarta.validation.Validator getValidator()>() 
(declare-const var1062!3 var2612)
(assert (not (= var1062!3 null-var2612)))
(assert (= (validator/105774719 var1062!3) var757)) ; Statement: r0.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: jakarta.validation.Validator validator> = $r5 
(define-const var629 var3877 var3877-init) ; Statement: $r6 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var629)) ; Statement: specialinvoke $r6.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var629!1 var3877)
(declare-const var1062!4 var2612)
(assert (not (= var1062!4 null-var2612)))
(assert (= (methodClassMap/105774719 var1062!4) (cast-from-var3877-to-var1075 var629!1))) ; Statement: r0.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.util.Map methodClassMap> = $r6 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2612-to-var1551=([org.apache.dubbo.validation.support.jvalidation.JValidatorNew], java.lang.Object), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), var1429_forName/-1763490630=([java.lang.String], java.lang.Class), clazz/105774719=([org.apache.dubbo.validation.support.jvalidation.JValidatorNew], java.lang.Class), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1178_isNotEmpty/-1251449450=([java.lang.String], boolean), var2492_byProvider/2067682699=([java.lang.Class], jakarta.validation.bootstrap.ProviderSpecificBootstrap), var2728_configure/991606694=([jakarta.validation.bootstrap.ProviderSpecificBootstrap], jakarta.validation.Configuration), var3617_buildValidatorFactory/-1780751643=([jakarta.validation.Configuration], jakarta.validation.ValidatorFactory), var2017_getValidator/1021903253=([jakarta.validation.ValidatorFactory], jakarta.validation.Validator), validator/105774719=([org.apache.dubbo.validation.support.jvalidation.JValidatorNew], jakarta.validation.Validator), var3877-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var3877-to-var1075=([java.util.concurrent.ConcurrentHashMap], java.util.Map), methodClassMap/105774719=([org.apache.dubbo.validation.support.jvalidation.JValidatorNew], java.util.Map)}
; {var2612=org.apache.dubbo.validation.support.jvalidation.JValidatorNew, var1062=r0, var3094=org.apache.dubbo.common.URL, var843=r1, var1551=java.lang.Object, var3155=$r2, var1429=org.apache.dubbo.common.utils.ReflectUtils, var1334=$r3, var2607=r4, var1178=org.apache.dubbo.common.utils.StringUtils, var1370=$z0, var622=$r7, var2728=jakarta.validation.bootstrap.ProviderSpecificBootstrap, var2492=jakarta.validation.Validation, var3833=$r8, var3617=jakarta.validation.Configuration, var1567=$r9, var2017=jakarta.validation.ValidatorFactory, var291=r10, var1416=jakarta.validation.Validator, var757=$r5, var3877=java.util.concurrent.ConcurrentHashMap, var629=$r6, var1075=java.util.Map}
; {org.apache.dubbo.validation.support.jvalidation.JValidatorNew=var2612, r0=var1062, org.apache.dubbo.common.URL=var3094, r1=var843, java.lang.Object=var1551, $r2=var3155, org.apache.dubbo.common.utils.ReflectUtils=var1429, $r3=var1334, r4=var2607, org.apache.dubbo.common.utils.StringUtils=var1178, $z0=var1370, $r7=var622, jakarta.validation.bootstrap.ProviderSpecificBootstrap=var2728, jakarta.validation.Validation=var2492, $r8=var3833, jakarta.validation.Configuration=var3617, $r9=var1567, jakarta.validation.ValidatorFactory=var2017, r10=var291, jakarta.validation.Validator=var1416, $r5=var757, java.util.concurrent.ConcurrentHashMap=var3877, $r6=var629, java.util.Map=var1075}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.validation.support.jvalidation.JValidatorNew;	r1 := @parameter0: org.apache.dubbo.common.URL;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>($r2);	r0.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> = $r3;	r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("jvalidationNew");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r4);	if $z0 == 0 goto r10 = staticinvoke <jakarta.validation.Validation: jakarta.validation.ValidatorFactory buildDefaultValidatorFactory()>();	$r7 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class forName(java.lang.String)>(r4);	$r8 = staticinvoke <jakarta.validation.Validation: jakarta.validation.bootstrap.ProviderSpecificBootstrap byProvider(java.lang.Class)>($r7);	$r9 = interfaceinvoke $r8.<jakarta.validation.bootstrap.ProviderSpecificBootstrap: jakarta.validation.Configuration configure()>();	r10 = interfaceinvoke $r9.<jakarta.validation.Configuration: jakarta.validation.ValidatorFactory buildValidatorFactory()>();	goto [?= $r5 = interfaceinvoke r10.<jakarta.validation.ValidatorFactory: jakarta.validation.Validator getValidator()>()];	$r5 = interfaceinvoke r10.<jakarta.validation.ValidatorFactory: jakarta.validation.Validator getValidator()>();	r0.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: jakarta.validation.Validator validator> = $r5;	$r6 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r6.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.util.Map methodClassMap> = $r6;	return
;block_num 3