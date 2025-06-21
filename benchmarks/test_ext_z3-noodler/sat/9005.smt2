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

(declare-sort var1503 0)
(declare-sort var1143 0)
(declare-sort var713 0)
(declare-sort var3641 0)
(declare-sort var355 0)
(declare-sort var1615 0)
(declare-sort var60 0)
(declare-sort var483 0)
(declare-sort var1674 0)
(declare-sort var3624 0)
(declare-sort var3505 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1615_getAttribute/147737434 (var713 String) var355)
(declare-fun cast-from-var355-to-String (var355) String)
(declare-fun var60_hasText/2115555376 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var355_toString/-522406933 (var355) String)
(declare-fun cast-from-var3641-to-var355 (var3641) var355)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var483_convertReferenceProps/-1256036247 (var713 ClassObject) void)
(declare-fun var713_get/1088891777 (var713 var355) var355)
(declare-fun cast-from-String-to-var355 (String) var355)
(declare-fun var1674_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var3624-init () var3624)
(declare-fun <init>/-2070561352 (var3624 String) void)
(declare-fun cast-from-var3624-to-var3505 (var3624) var3505)
(declare-const null-var1503 var1503)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var713 var713)
(declare-const null-var3641 var3641)
(declare-const var1817 var1503) ; Statement: r10 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor 
(assert (not (= var1817 null-var1503)))
(declare-const var3530 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3530 null-String)))
(declare-const var2323 ClassObject) ; Statement: r8 := @parameter1: java.lang.Class 
(assert (not (= var2323 null-ClassObject)))
(declare-const var3560 var713) ; Statement: r0 := @parameter2: java.util.Map 
(assert (not (= var3560 null-var713)))
(declare-const var3523 var3641) ; Statement: r4 := @parameter3: java.lang.reflect.Member 
(assert (not (= var3523 null-var3641)))
(define-const var1244 Bool (ite (= 1 1) true false)) ; Statement: z11 = 1 
(define-const var169 var355 (var1615_getAttribute/147737434 var3560 "id")) ; Statement: $r1 = staticinvoke <org.apache.dubbo.config.spring.util.AnnotationUtils: java.lang.Object getAttribute(java.util.Map,java.lang.String)>(r0, "id") 
(define-const var3149 String (cast-from-var355-to-String var169)) ; Statement: r92 = (java.lang.String) $r1 
(define-const var2314 Bool (var60_hasText/2115555376 var3149)) ; Statement: $z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r92) 
 ; Statement: if $z0 == 0 goto r92 = r2 
(assert (= (ite var2314 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3149!1 String var3530) ; Statement: r92 = r2 
(assert true) ; Non Conditional
(define-const var303 String String-init) ; Statement: $r119 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var303)) ; Statement: specialinvoke $r119.<java.lang.StringBuilder: void <init>()>() 
(declare-const var303!1 String)
(assert (= var303!1 ""))
(assert true)
(define-const var559 String (append/672562846 var303!1 "Please check ")) ; Statement: $r6 = virtualinvoke $r119.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Please check ") 
(declare-const var303!2 String)
(assert (= var303!2 (str.++ var303!1 "Please check ")))
(define-const var1773 String (var355_toString/-522406933 (cast-from-var3641-to-var355 var3523))) ; Statement: $r5 = interfaceinvoke r4.<java.lang.reflect.Member: java.lang.String toString()>() 
(assert true)
(define-const var1628 String (append/672562846 var559 var1773)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var559!1 String)
(assert (= var559!1 (str.++ var559 var1773)))
(assert true)
(define-const var3276 String (toString/-2075883882 var1628)) ; Statement: $r90 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var483_convertReferenceProps/-1256036247 var3560 var2323)) ; Statement: staticinvoke <org.apache.dubbo.config.spring.reference.ReferenceBeanSupport: void convertReferenceProps(java.util.Map,java.lang.Class)>(r0, r8) 

(declare-const var3560!1 var713)
(declare-const var2323!1 ClassObject)
(define-const var3745 var355 (var713_get/1088891777 var3560!1 (cast-from-String-to-var355 "interface"))) ; Statement: $r9 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface") 
(define-const var1666 String (cast-from-var355-to-String var3745)) ; Statement: $r91 = (java.lang.String) $r9 
(define-const var2191 Bool (var1674_isBlank/-523695098 (cast-from-String-to-String var1666))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r91) 
 ; Statement: if $z1 == 0 goto $r11 = r10.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: org.springframework.context.ApplicationContext applicationContext> 
(assert (not (= (ite var2191 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2239 var3624 var3624-init) ; Statement: $r121 = new org.springframework.beans.factory.BeanCreationException 
(define-const var2698 String String-init) ; Statement: $r120 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2698)) ; Statement: specialinvoke $r120.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2698!1 String)
(assert (= var2698!1 ""))
(assert true)
(define-const var1007 String (append/672562846 var2698!1 "Need to specify the \u0027interfaceName\u0027 or \u0027interfaceClass\u0027 attribute of \u0027@DubboReference\u0027 if enable generic. ")) ; Statement: $r87 = virtualinvoke $r120.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Need to specify the \'interfaceName\' or \'interfaceClass\' attribute of \'@DubboReference\' if enable generic. ") 
(declare-const var2698!2 String)
(assert (= var2698!2 (str.++ var2698!1 "Need to specify the \u0027interfaceName\u0027 or \u0027interfaceClass\u0027 attribute of \u0027@DubboReference\u0027 if enable generic. ")))
(assert true)
(define-const var3660 String (append/672562846 var1007 var3276)) ; Statement: $r88 = virtualinvoke $r87.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r90) 
(declare-const var1007!1 String)
(assert (= var1007!1 (str.++ var1007 var3276)))
(assert true)
(define-const var546 String (toString/-2075883882 var3660)) ; Statement: $r89 = virtualinvoke $r88.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-2070561352 var2239 var546)) ; Statement: specialinvoke $r121.<org.springframework.beans.factory.BeanCreationException: void <init>(java.lang.String)>($r89) 

(declare-const var2239!1 var3624)
(declare-const var546!1 String)
(define-const var1387 var3505 (cast-from-var3624-to-var3505 var2239!1)) ; Statement: $r135 = (java.lang.Throwable) $r121 
 ; Statement: throw $r135 
(check-sat)
; {var1615_getAttribute/147737434=([java.util.Map, java.lang.String], java.lang.Object), cast-from-var355-to-String=([java.lang.Object], java.lang.String), var60_hasText/2115555376=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var355_toString/-522406933=([java.lang.Object], java.lang.String), cast-from-var3641-to-var355=([java.lang.reflect.Member], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var483_convertReferenceProps/-1256036247=([java.util.Map, java.lang.Class], void), var713_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var355=([java.lang.String], java.lang.Object), var1674_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var3624-init=([], org.springframework.beans.factory.BeanCreationException), <init>/-2070561352=([org.springframework.beans.factory.BeanCreationException, java.lang.String], void), cast-from-var3624-to-var3505=([org.springframework.beans.factory.BeanCreationException], java.lang.Throwable)}
; {var1503=org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor, var1817=r10, var3530=r2, var1143=null_type, var2323=r8, var713=java.util.Map, var3560=r0, var3641=java.lang.reflect.Member, var3523=r4, var1244=z11, var355=java.lang.Object, var1615=org.apache.dubbo.config.spring.util.AnnotationUtils, var169=$r1, var3149=r92, var60=org.springframework.util.StringUtils, var2314=$z0, var303=$r119, var559=$r6, var1773=$r5, var1628=$r7, var3276=$r90, var483=org.apache.dubbo.config.spring.reference.ReferenceBeanSupport, var3745=$r9, var1666=$r91, var1674=org.apache.dubbo.common.utils.StringUtils, var2191=$z1, var3624=org.springframework.beans.factory.BeanCreationException, var2239=$r121, var2698=$r120, var1007=$r87, var3660=$r88, var546=$r89, var3505=java.lang.Throwable, var1387=$r135}
; {org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor=var1503, r10=var1817, r2=var3530, null_type=var1143, r8=var2323, java.util.Map=var713, r0=var3560, java.lang.reflect.Member=var3641, r4=var3523, z11=var1244, java.lang.Object=var355, org.apache.dubbo.config.spring.util.AnnotationUtils=var1615, $r1=var169, r92=var3149, org.springframework.util.StringUtils=var60, $z0=var2314, $r119=var303, $r6=var559, $r5=var1773, $r7=var1628, $r90=var3276, org.apache.dubbo.config.spring.reference.ReferenceBeanSupport=var483, $r9=var3745, $r91=var1666, org.apache.dubbo.common.utils.StringUtils=var1674, $z1=var2191, org.springframework.beans.factory.BeanCreationException=var3624, $r121=var2239, $r120=var2698, $r87=var1007, $r88=var3660, $r89=var546, java.lang.Throwable=var3505, $r135=var1387}
;seq <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Object: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.springframework.util.StringUtils: boolean hasText(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r10 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor;	r2 := @parameter0: java.lang.String;	r8 := @parameter1: java.lang.Class;	r0 := @parameter2: java.util.Map;	r4 := @parameter3: java.lang.reflect.Member;	z11 = 1;	$r1 = staticinvoke <org.apache.dubbo.config.spring.util.AnnotationUtils: java.lang.Object getAttribute(java.util.Map,java.lang.String)>(r0, "id");	r92 = (java.lang.String) $r1;	$z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r92);	if $z0 == 0 goto r92 = r2;	r92 = r2;	$r119 = new java.lang.StringBuilder;	specialinvoke $r119.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r119.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Please check ");	$r5 = interfaceinvoke r4.<java.lang.reflect.Member: java.lang.String toString()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r90 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	staticinvoke <org.apache.dubbo.config.spring.reference.ReferenceBeanSupport: void convertReferenceProps(java.util.Map,java.lang.Class)>(r0, r8);	$r9 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface");	$r91 = (java.lang.String) $r9;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r91);	if $z1 == 0 goto $r11 = r10.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: org.springframework.context.ApplicationContext applicationContext>;	$r121 = new org.springframework.beans.factory.BeanCreationException;	$r120 = new java.lang.StringBuilder;	specialinvoke $r120.<java.lang.StringBuilder: void <init>()>();	$r87 = virtualinvoke $r120.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Need to specify the \'interfaceName\' or \'interfaceClass\' attribute of \'@DubboReference\' if enable generic. ");	$r88 = virtualinvoke $r87.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r90);	$r89 = virtualinvoke $r88.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r121.<org.springframework.beans.factory.BeanCreationException: void <init>(java.lang.String)>($r89);	$r135 = (java.lang.Throwable) $r121;	throw $r135
;block_num 4