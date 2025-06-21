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

(declare-sort var735 0)
(declare-sort var974 0)
(declare-sort var3637 0)
(declare-sort var2930 0)
(declare-sort var1330 0)
(declare-sort var499 0)
(declare-sort var2973 0)
(declare-sort var1555 0)
(declare-sort var54 0)
(declare-sort var3187 0)
(declare-sort var286 0)
(declare-sort var2766 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2766!class ClassObject)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun url/1800549272 (var2930) String)
(declare-fun cast-from-var735-to-var2930 (var735) var2930)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3637_warn/126438324 (var3637 String String String String var974) void)
(declare-fun consumerModel/624895015 (var735) var1330)
(declare-fun initialized/624895015 (var735) Bool)
(declare-fun invoker/624895015 (var735) var499)
(declare-fun ref/624895015 (var735) var2973)
(declare-fun serviceMetadata/2049477907 (var54) var1555)
(declare-fun cast-from-var735-to-var54 (var735) var54)
(declare-fun setTarget/-251600361 (var1555 var2973) void)
(declare-fun getAttributeMap/1203901181 (var1555) var286)
(declare-fun var286_remove/-1201052315 (var286 var2973) var2973)
(declare-fun cast-from-String-to-var2973 (String) var2973)
(declare-fun getClass/1258963082 (var2973) ClassObject)
(declare-fun cast-from-var974-to-var2973 (var974) var2973)
(declare-const null-var735 var735)
(declare-const null-var974 var974)
(declare-const var735-logger var3637)
(declare-const null-var1330 var1330)
(declare-const null-var499 var499)
(declare-const null-var2973 var2973)
(declare-const null-NullType var3187)
(declare-const var8 var735) ; Statement: r0 := @this: org.apache.dubbo.config.ReferenceConfig 
(assert (not (= var8 null-var735)))
(declare-const var1270 var974) ; Statement: r6 := @parameter0: java.lang.Throwable 
(assert (not (= var1270 null-var974)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3859 var974) ; Statement: $r13 := @caughtexception 
(assert (not (= var3859 null-var974)))
(define-const var3774 var3637 var735-logger) ; Statement: $r15 = <org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1422 String String-init) ; Statement: $r14 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1422)) ; Statement: specialinvoke $r14.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1422!1 String)
(assert (= var1422!1 ""))
(assert true)
(define-const var278 String (append/672562846 var1422!1 "Unexpected error occurred when destroy invoker of ReferenceConfig(")) ; Statement: $r17 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unexpected error occurred when destroy invoker of ReferenceConfig(") 
(declare-const var1422!2 String)
(assert (= var1422!2 (str.++ var1422!1 "Unexpected error occurred when destroy invoker of ReferenceConfig(")))
(define-const var1526 String (url/1800549272 (cast-from-var735-to-var2930 var8))) ; Statement: $r16 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String url> 
(assert true)
(define-const var3815 String (append/672562846 var278 var1526)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16) 
(declare-const var278!1 String)
(assert (= var278!1 (str.++ var278 var1526)))
(assert true)
(define-const var3108 String (append/672562846 var3815 ").")) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(").") 
(declare-const var3815!1 String)
(assert (= var3815!1 (str.++ var3815 ").")))
(assert true)
(define-const var1649 String (toString/-2075883882 var3108)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3637_warn/126438324 var3774 "5-3" "" "" var1649 var1270)) ; Statement: interfaceinvoke $r15.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("5-3", "", "", $r20, r6) 

(declare-const var3774!1 var3637)
(declare-const var1416 String)
(declare-const var2775 String)
(declare-const var2775!1 String)
(declare-const var1649!1 String)
(declare-const var1270!1 var974)
(assert true) ; Non Conditional
(define-const var3789 var1330 (consumerModel/624895015 var8)) ; Statement: $r2 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ConsumerModel consumerModel> 
 ; Statement: if $r2 == null goto r0.<org.apache.dubbo.config.ReferenceConfig: boolean initialized> = 0 
(assert (= var3789 null-var1330)) ; Cond: $r2 == null 
(declare-const var8!1 var735)
(assert (not (= var8!1 null-var735)))
(assert (= (initialized/624895015 var8!1) (ite (= 1 0) true false))) ; Statement: r0.<org.apache.dubbo.config.ReferenceConfig: boolean initialized> = 0 
(declare-const var8!2 var735)
(assert (not (= var8!2 null-var735)))
(assert (= (invoker/624895015 var8!2) null-var499)) ; Statement: r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.Invoker invoker> = null 
(declare-const var8!3 var735)
(assert (not (= var8!3 null-var735)))
(assert (= (ref/624895015 var8!3) null-var2973)) ; Statement: r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.Object ref> = null 
(declare-const var8!4 var735)
(assert (not (= var8!4 null-var735)))
(assert (= (consumerModel/624895015 var8!4) null-var1330)) ; Statement: r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ConsumerModel consumerModel> = null 
(define-const var3483 var1555 (serviceMetadata/2049477907 (cast-from-var735-to-var54 var8!4))) ; Statement: $r3 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ServiceMetadata serviceMetadata> 
(assert true)
;(assert (setTarget/-251600361 var3483 null-var2973)) ; Statement: virtualinvoke $r3.<org.apache.dubbo.rpc.model.ServiceMetadata: void setTarget(java.lang.Object)>(null) 

(declare-const var3483!1 var1555)
(declare-const var2327 var3187)
(define-const var994 var1555 (serviceMetadata/2049477907 (cast-from-var735-to-var54 var8!4))) ; Statement: $r4 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ServiceMetadata serviceMetadata> 
(assert true)
(define-const var3211 var286 (getAttributeMap/1203901181 var994)) ; Statement: $r5 = virtualinvoke $r4.<org.apache.dubbo.rpc.model.ServiceMetadata: java.util.Map getAttributeMap()>() 
;(assert (var286_remove/-1201052315 var3211 (cast-from-String-to-var2973 "refClass"))) ; Statement: interfaceinvoke $r5.<java.util.Map: java.lang.Object remove(java.lang.Object)>("refClass") 

(declare-const var3211!1 var286)
(declare-const var3563 String)
(assert true)
(define-const var1451 ClassObject (getClass/1258963082 (cast-from-var974-to-var2973 var1270!1))) ; Statement: $r7 = virtualinvoke r6.<java.lang.Object: java.lang.Class getClass()>() 
 ; Statement: if $r7 != class "Ljava/lang/IllegalStateException;" goto return 
(assert (not (= var1451 var2766!class))) ; Cond: $r7 != class "Ljava/lang/IllegalStateException;" 
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), url/1800549272=([org.apache.dubbo.config.ReferenceConfigBase], java.lang.String), cast-from-var735-to-var2930=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.ReferenceConfigBase), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3637_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), consumerModel/624895015=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.rpc.model.ConsumerModel), initialized/624895015=([org.apache.dubbo.config.ReferenceConfig], boolean), invoker/624895015=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.rpc.Invoker), ref/624895015=([org.apache.dubbo.config.ReferenceConfig], java.lang.Object), serviceMetadata/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], org.apache.dubbo.rpc.model.ServiceMetadata), cast-from-var735-to-var54=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractInterfaceConfig), setTarget/-251600361=([org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.Object], void), getAttributeMap/1203901181=([org.apache.dubbo.rpc.model.ServiceMetadata], java.util.Map), var286_remove/-1201052315=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2973=([java.lang.String], java.lang.Object), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var974-to-var2973=([java.lang.Throwable], java.lang.Object)}
; {var735=org.apache.dubbo.config.ReferenceConfig, var8=r0, var974=java.lang.Throwable, var1270=r6, var3859=$r13, var3637=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3774=$r15, var1422=$r14, var278=$r17, var2930=org.apache.dubbo.config.ReferenceConfigBase, var1526=$r16, var3815=$r18, var3108=$r19, var1649=$r20, var1416="5-3", var2775="", var1330=org.apache.dubbo.rpc.model.ConsumerModel, var3789=$r2, var499=org.apache.dubbo.rpc.Invoker, var2973=java.lang.Object, var1555=org.apache.dubbo.rpc.model.ServiceMetadata, var54=org.apache.dubbo.config.AbstractInterfaceConfig, var3483=$r3, var2327=null, var3187=null_type, var994=$r4, var286=java.util.Map, var3211=$r5, var3563="refClass", var1451=$r7, var2766=java.lang.IllegalStateException}
; {org.apache.dubbo.config.ReferenceConfig=var735, r0=var8, java.lang.Throwable=var974, r6=var1270, $r13=var3859, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3637, $r15=var3774, $r14=var1422, $r17=var278, org.apache.dubbo.config.ReferenceConfigBase=var2930, $r16=var1526, $r18=var3815, $r19=var3108, $r20=var1649, "5-3"=var1416, ""=var2775, org.apache.dubbo.rpc.model.ConsumerModel=var1330, $r2=var3789, org.apache.dubbo.rpc.Invoker=var499, java.lang.Object=var2973, org.apache.dubbo.rpc.model.ServiceMetadata=var1555, org.apache.dubbo.config.AbstractInterfaceConfig=var54, $r3=var3483, null=var2327, null_type=var3187, $r4=var994, java.util.Map=var286, $r5=var3211, "refClass"=var3563, $r7=var1451, java.lang.IllegalStateException=var2766}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ReferenceConfig;	r6 := @parameter0: java.lang.Throwable;	$r13 := @caughtexception;	$r15 = <org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r14 = new java.lang.StringBuilder;	specialinvoke $r14.<java.lang.StringBuilder: void <init>()>();	$r17 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unexpected error occurred when destroy invoker of ReferenceConfig(");	$r16 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String url>;	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(").");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r15.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("5-3", "", "", $r20, r6);	$r2 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ConsumerModel consumerModel>;	if $r2 == null goto r0.<org.apache.dubbo.config.ReferenceConfig: boolean initialized> = 0;	r0.<org.apache.dubbo.config.ReferenceConfig: boolean initialized> = 0;	r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.Invoker invoker> = null;	r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.Object ref> = null;	r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ConsumerModel consumerModel> = null;	$r3 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ServiceMetadata serviceMetadata>;	virtualinvoke $r3.<org.apache.dubbo.rpc.model.ServiceMetadata: void setTarget(java.lang.Object)>(null);	$r4 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ServiceMetadata serviceMetadata>;	$r5 = virtualinvoke $r4.<org.apache.dubbo.rpc.model.ServiceMetadata: java.util.Map getAttributeMap()>();	interfaceinvoke $r5.<java.util.Map: java.lang.Object remove(java.lang.Object)>("refClass");	$r7 = virtualinvoke r6.<java.lang.Object: java.lang.Class getClass()>();	if $r7 != class "Ljava/lang/IllegalStateException;" goto return;	return
;block_num 5