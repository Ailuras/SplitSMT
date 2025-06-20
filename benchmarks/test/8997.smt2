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

(declare-sort var3998 0)
(declare-sort var2556 0)
(declare-sort var1556 0)
(declare-sort var1875 0)
(declare-sort var434 0)
(declare-sort var2116 0)
(declare-sort var2418 0)
(declare-sort var3191 0)
(declare-sort var1004 0)
(declare-sort var3070 0)
(declare-sort var1000 0)
(declare-sort var1922 0)
(declare-sort var2997 0)
(declare-sort var2612 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1875-init () var1875)
(declare-fun <init>/-1247439778 (var1875 var434) void)
(declare-fun cast-from-var1556-to-var434 (var1556) var434)
(declare-fun isIgnoreInvalidFields/1420429490 (var2116) Bool)
(declare-fun cast-from-var3998-to-var2116 (var3998) var2116)
(declare-fun setIgnoreInvalidFields/1455082609 (var1875 Bool) void)
(declare-fun isIgnoreUnknownFields/370490303 (var2116) Bool)
(declare-fun setIgnoreUnknownFields/1498382532 (var1875 Bool) void)
(declare-fun getPropertySources/-1188627289 (var2116) var2418)
(declare-fun var1004_getSubProperties/-1034417734 (var2418 String) var3191)
(declare-fun var3070-init () var3070)
(declare-fun <init>/-2022687438 (var3070 var3191) void)
(declare-fun cast-from-var3070-to-var1000 (var3070) var1000)
(declare-fun bind/502751913 (var1875 var1000) void)
(declare-fun getBindingResult/88927633 (var1875) var1922)
(declare-fun var1922_hasGlobalErrors/353901891 (var1922) Bool)
(declare-fun var2997-init () var2997)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1922_getGlobalError/-1924060545 (var1922) var2612)
(declare-fun append/-1031950772 (String var434) String)
(declare-fun cast-from-var2612-to-var434 (var2612) var434)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1084991535 (var2997 String) void)
(declare-const null-var3998 var3998)
(declare-const null-String String)
(declare-const null-var1556 var1556)
(declare-const var2754 var3998) ; Statement: r2 := @this: org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder 
(assert (not (= var2754 null-var3998)))
(declare-const var1797 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var1797 null-String)))
(declare-const var3637 var1556) ; Statement: r1 := @parameter1: org.apache.dubbo.config.AbstractConfig 
(assert (not (= var3637 null-var1556)))
(define-const var3565 var1875 var1875-init) ; Statement: $r20 = new org.springframework.validation.DataBinder 
(assert true)
;(assert (<init>/-1247439778 var3565 (cast-from-var1556-to-var434 var3637))) ; Statement: specialinvoke $r20.<org.springframework.validation.DataBinder: void <init>(java.lang.Object)>(r1) 

(declare-const var3565!1 var1875)
(declare-const var3637!1 var1556)
(assert true)
(define-const var3388 Bool (isIgnoreInvalidFields/1420429490 (cast-from-var3998-to-var2116 var2754))) ; Statement: $z0 = virtualinvoke r2.<org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder: boolean isIgnoreInvalidFields()>() 
(assert true)
;(assert (setIgnoreInvalidFields/1455082609 var3565!1 var3388)) ; Statement: virtualinvoke $r20.<org.springframework.validation.DataBinder: void setIgnoreInvalidFields(boolean)>($z0) 

(declare-const var3565!2 var1875)
(declare-const var3388!1 Bool)
(assert true)
(define-const var3330 Bool (isIgnoreUnknownFields/370490303 (cast-from-var3998-to-var2116 var2754))) ; Statement: $z1 = virtualinvoke r2.<org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder: boolean isIgnoreUnknownFields()>() 
(assert true)
;(assert (setIgnoreUnknownFields/1498382532 var3565!2 var3330)) ; Statement: virtualinvoke $r20.<org.springframework.validation.DataBinder: void setIgnoreUnknownFields(boolean)>($z1) 

(declare-const var3565!3 var1875)
(declare-const var3330!1 Bool)
(assert true)
(define-const var3239 var2418 (getPropertySources/-1188627289 (cast-from-var3998-to-var2116 var2754))) ; Statement: $r4 = virtualinvoke r2.<org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder: java.lang.Iterable getPropertySources()>() 
(define-const var2851 var3191 (var1004_getSubProperties/-1034417734 var3239 var1797)) ; Statement: r5 = staticinvoke <org.apache.dubbo.config.spring.util.PropertySourcesUtils: java.util.Map getSubProperties(java.lang.Iterable,java.lang.String)>($r4, r3) 
(define-const var3975 var3070 var3070-init) ; Statement: $r21 = new org.springframework.beans.MutablePropertyValues 
(assert true)
;(assert (<init>/-2022687438 var3975 var2851)) ; Statement: specialinvoke $r21.<org.springframework.beans.MutablePropertyValues: void <init>(java.util.Map)>(r5) 

(declare-const var3975!1 var3070)
(declare-const var2851!1 var3191)
(define-const var3997 var1000 (cast-from-var3070-to-var1000 var3975!1)) ; Statement: $r25 = (org.springframework.beans.PropertyValues) $r21 
(assert true)
;(assert (bind/502751913 var3565!3 var3997)) ; Statement: virtualinvoke $r20.<org.springframework.validation.DataBinder: void bind(org.springframework.beans.PropertyValues)>($r25) 

(declare-const var3565!4 var1875)
(declare-const var3997!1 var1000)
(assert true)
(define-const var2793 var1922 (getBindingResult/88927633 var3565!4)) ; Statement: r7 = virtualinvoke $r20.<org.springframework.validation.DataBinder: org.springframework.validation.BindingResult getBindingResult()>() 
(define-const var3031 Bool (var1922_hasGlobalErrors/353901891 var2793)) ; Statement: $z2 = interfaceinvoke r7.<org.springframework.validation.BindingResult: boolean hasGlobalErrors()>() 
 ; Statement: if $z2 == 0 goto $z3 = interfaceinvoke r7.<org.springframework.validation.BindingResult: boolean hasFieldErrors()>() 
(assert (not (= (ite var3031 1 0) 0))) ; Negate: Cond: $z2 == 0  
(define-const var3517 var2997 var2997-init) ; Statement: $r23 = new java.lang.RuntimeException 
(define-const var89 String String-init) ; Statement: $r22 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var89)) ; Statement: specialinvoke $r22.<java.lang.StringBuilder: void <init>()>() 
(declare-const var89!1 String)
(assert (= var89!1 ""))
(assert true)
(define-const var2746 String (append/672562846 var89!1 "Data bind global error, please check config. config: ")) ; Statement: $r16 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Data bind global error, please check config. config: ") 
(declare-const var89!2 String)
(assert (= var89!2 (str.++ var89!1 "Data bind global error, please check config. config: ")))
(define-const var916 var2612 (var1922_getGlobalError/-1924060545 var2793)) ; Statement: $r15 = interfaceinvoke r7.<org.springframework.validation.BindingResult: org.springframework.validation.ObjectError getGlobalError()>() 
(assert true)
(define-const var1537 String (append/-1031950772 var2746 (cast-from-var2612-to-var434 var916))) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r15) 
(declare-const var2746!1 String)
(assert (str.prefixof var2746 var2746!1))
(assert true)
(define-const var2821 String (append/672562846 var1537 "")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("") 
(declare-const var1537!1 String)
(assert (= var1537!1 (str.++ var1537 "")))
(assert true)
(define-const var2171 String (toString/-2075883882 var2821)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1084991535 var3517 var2171)) ; Statement: specialinvoke $r23.<java.lang.RuntimeException: void <init>(java.lang.String)>($r19) 

(declare-const var3517!1 var2997)
(declare-const var2171!1 String)
 ; Statement: throw $r23 
(check-sat)
; {var1875-init=([], org.springframework.validation.DataBinder), <init>/-1247439778=([org.springframework.validation.DataBinder, java.lang.Object], void), cast-from-var1556-to-var434=([org.apache.dubbo.config.AbstractConfig], java.lang.Object), isIgnoreInvalidFields/1420429490=([org.apache.dubbo.config.spring.context.properties.AbstractDubboConfigBinder], boolean), cast-from-var3998-to-var2116=([org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder], org.apache.dubbo.config.spring.context.properties.AbstractDubboConfigBinder), setIgnoreInvalidFields/1455082609=([org.springframework.validation.DataBinder, boolean], void), isIgnoreUnknownFields/370490303=([org.apache.dubbo.config.spring.context.properties.AbstractDubboConfigBinder], boolean), setIgnoreUnknownFields/1498382532=([org.springframework.validation.DataBinder, boolean], void), getPropertySources/-1188627289=([org.apache.dubbo.config.spring.context.properties.AbstractDubboConfigBinder], java.lang.Iterable), var1004_getSubProperties/-1034417734=([java.lang.Iterable, java.lang.String], java.util.Map), var3070-init=([], org.springframework.beans.MutablePropertyValues), <init>/-2022687438=([org.springframework.beans.MutablePropertyValues, java.util.Map], void), cast-from-var3070-to-var1000=([org.springframework.beans.MutablePropertyValues], org.springframework.beans.PropertyValues), bind/502751913=([org.springframework.validation.DataBinder, org.springframework.beans.PropertyValues], void), getBindingResult/88927633=([org.springframework.validation.DataBinder], org.springframework.validation.BindingResult), var1922_hasGlobalErrors/353901891=([org.springframework.validation.BindingResult], boolean), var2997-init=([], java.lang.RuntimeException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1922_getGlobalError/-1924060545=([org.springframework.validation.BindingResult], org.springframework.validation.ObjectError), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2612-to-var434=([org.springframework.validation.ObjectError], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var3998=org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder, var2754=r2, var1797=r3, var2556=null_type, var1556=org.apache.dubbo.config.AbstractConfig, var3637=r1, var1875=org.springframework.validation.DataBinder, var3565=$r20, var434=java.lang.Object, var2116=org.apache.dubbo.config.spring.context.properties.AbstractDubboConfigBinder, var3388=$z0, var3330=$z1, var2418=java.lang.Iterable, var3239=$r4, var3191=java.util.Map, var1004=org.apache.dubbo.config.spring.util.PropertySourcesUtils, var2851=r5, var3070=org.springframework.beans.MutablePropertyValues, var3975=$r21, var1000=org.springframework.beans.PropertyValues, var3997=$r25, var1922=org.springframework.validation.BindingResult, var2793=r7, var3031=$z2, var2997=java.lang.RuntimeException, var3517=$r23, var89=$r22, var2746=$r16, var2612=org.springframework.validation.ObjectError, var916=$r15, var1537=$r17, var2821=$r18, var2171=$r19}
; {org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder=var3998, r2=var2754, r3=var1797, null_type=var2556, org.apache.dubbo.config.AbstractConfig=var1556, r1=var3637, org.springframework.validation.DataBinder=var1875, $r20=var3565, java.lang.Object=var434, org.apache.dubbo.config.spring.context.properties.AbstractDubboConfigBinder=var2116, $z0=var3388, $z1=var3330, java.lang.Iterable=var2418, $r4=var3239, java.util.Map=var3191, org.apache.dubbo.config.spring.util.PropertySourcesUtils=var1004, r5=var2851, org.springframework.beans.MutablePropertyValues=var3070, $r21=var3975, org.springframework.beans.PropertyValues=var1000, $r25=var3997, org.springframework.validation.BindingResult=var1922, r7=var2793, $z2=var3031, java.lang.RuntimeException=var2997, $r23=var3517, $r22=var89, $r16=var2746, org.springframework.validation.ObjectError=var2612, $r15=var916, $r17=var1537, $r18=var2821, $r19=var2171}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder;	r3 := @parameter0: java.lang.String;	r1 := @parameter1: org.apache.dubbo.config.AbstractConfig;	$r20 = new org.springframework.validation.DataBinder;	specialinvoke $r20.<org.springframework.validation.DataBinder: void <init>(java.lang.Object)>(r1);	$z0 = virtualinvoke r2.<org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder: boolean isIgnoreInvalidFields()>();	virtualinvoke $r20.<org.springframework.validation.DataBinder: void setIgnoreInvalidFields(boolean)>($z0);	$z1 = virtualinvoke r2.<org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder: boolean isIgnoreUnknownFields()>();	virtualinvoke $r20.<org.springframework.validation.DataBinder: void setIgnoreUnknownFields(boolean)>($z1);	$r4 = virtualinvoke r2.<org.apache.dubbo.config.spring.context.properties.DefaultDubboConfigBinder: java.lang.Iterable getPropertySources()>();	r5 = staticinvoke <org.apache.dubbo.config.spring.util.PropertySourcesUtils: java.util.Map getSubProperties(java.lang.Iterable,java.lang.String)>($r4, r3);	$r21 = new org.springframework.beans.MutablePropertyValues;	specialinvoke $r21.<org.springframework.beans.MutablePropertyValues: void <init>(java.util.Map)>(r5);	$r25 = (org.springframework.beans.PropertyValues) $r21;	virtualinvoke $r20.<org.springframework.validation.DataBinder: void bind(org.springframework.beans.PropertyValues)>($r25);	r7 = virtualinvoke $r20.<org.springframework.validation.DataBinder: org.springframework.validation.BindingResult getBindingResult()>();	$z2 = interfaceinvoke r7.<org.springframework.validation.BindingResult: boolean hasGlobalErrors()>();	if $z2 == 0 goto $z3 = interfaceinvoke r7.<org.springframework.validation.BindingResult: boolean hasFieldErrors()>();	$r23 = new java.lang.RuntimeException;	$r22 = new java.lang.StringBuilder;	specialinvoke $r22.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Data bind global error, please check config. config: ");	$r15 = interfaceinvoke r7.<org.springframework.validation.BindingResult: org.springframework.validation.ObjectError getGlobalError()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r15);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r23.<java.lang.RuntimeException: void <init>(java.lang.String)>($r19);	throw $r23
;block_num 2