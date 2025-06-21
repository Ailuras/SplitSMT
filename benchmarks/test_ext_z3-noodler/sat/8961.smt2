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

(declare-sort var2186 0)
(declare-sort var378 0)
(declare-sort var2821 0)
(declare-sort var2830 0)
(declare-sort var175 0)
(declare-sort var32 0)
(declare-sort var3495 0)
(declare-sort var2910 0)
(declare-sort var133 0)
(declare-sort var735 0)
(declare-sort var2102 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var32_getAttribute/147737434 (var2821 String) var175)
(declare-fun cast-from-var175-to-String (var175) String)
(declare-fun var3495_hasText/2115555376 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var175_toString/-522406933 (var175) String)
(declare-fun cast-from-var2830-to-var175 (var2830) var175)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2910_convertReferenceProps/-1256036247 (var2821 ClassObject) void)
(declare-fun var2821_get/1088891777 (var2821 var175) var175)
(declare-fun cast-from-String-to-var175 (String) var175)
(declare-fun var133_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var735-init () var735)
(declare-fun <init>/-2070561352 (var735 String) void)
(declare-fun cast-from-var735-to-var2102 (var735) var2102)
(declare-const null-var2186 var2186)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2821 var2821)
(declare-const null-var2830 var2830)
(declare-const var3813 var2186) ; Statement: r10 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor 
(assert (not (= var3813 null-var2186)))
(declare-const var2376 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2376 null-String)))
(declare-const var1144 ClassObject) ; Statement: r8 := @parameter1: java.lang.Class 
(assert (not (= var1144 null-ClassObject)))
(declare-const var219 var2821) ; Statement: r0 := @parameter2: java.util.Map 
(assert (not (= var219 null-var2821)))
(declare-const var586 var2830) ; Statement: r4 := @parameter3: java.lang.reflect.Member 
(assert (not (= var586 null-var2830)))
(define-const var433 Bool (ite (= 1 1) true false)) ; Statement: z11 = 1 
(define-const var1272 var175 (var32_getAttribute/147737434 var219 "id")) ; Statement: $r1 = staticinvoke <org.apache.dubbo.config.spring.util.AnnotationUtils: java.lang.Object getAttribute(java.util.Map,java.lang.String)>(r0, "id") 
(define-const var2 String (cast-from-var175-to-String var1272)) ; Statement: r92 = (java.lang.String) $r1 
(define-const var1923 Bool (var3495_hasText/2115555376 var2)) ; Statement: $z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r92) 
 ; Statement: if $z0 == 0 goto r92 = r2 
(assert (not (= (ite var1923 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var433!1 Bool (ite (= 1 0) true false)) ; Statement: z11 = 0 
 ; Statement: goto [?= $r119 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var3562 String String-init) ; Statement: $r119 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3562)) ; Statement: specialinvoke $r119.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3562!1 String)
(assert (= var3562!1 ""))
(assert true)
(define-const var1903 String (append/672562846 var3562!1 "Please check ")) ; Statement: $r6 = virtualinvoke $r119.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Please check ") 
(declare-const var3562!2 String)
(assert (= var3562!2 (str.++ var3562!1 "Please check ")))
(define-const var237 String (var175_toString/-522406933 (cast-from-var2830-to-var175 var586))) ; Statement: $r5 = interfaceinvoke r4.<java.lang.reflect.Member: java.lang.String toString()>() 
(assert true)
(define-const var174 String (append/672562846 var1903 var237)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1903!1 String)
(assert (= var1903!1 (str.++ var1903 var237)))
(assert true)
(define-const var1505 String (toString/-2075883882 var174)) ; Statement: $r90 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2910_convertReferenceProps/-1256036247 var219 var1144)) ; Statement: staticinvoke <org.apache.dubbo.config.spring.reference.ReferenceBeanSupport: void convertReferenceProps(java.util.Map,java.lang.Class)>(r0, r8) 

(declare-const var219!1 var2821)
(declare-const var1144!1 ClassObject)
(define-const var3417 var175 (var2821_get/1088891777 var219!1 (cast-from-String-to-var175 "interface"))) ; Statement: $r9 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface") 
(define-const var91 String (cast-from-var175-to-String var3417)) ; Statement: $r91 = (java.lang.String) $r9 
(define-const var3190 Bool (var133_isBlank/-523695098 (cast-from-String-to-String var91))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r91) 
 ; Statement: if $z1 == 0 goto $r11 = r10.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: org.springframework.context.ApplicationContext applicationContext> 
(assert (not (= (ite var3190 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var1519 var735 var735-init) ; Statement: $r121 = new org.springframework.beans.factory.BeanCreationException 
(define-const var500 String String-init) ; Statement: $r120 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var500)) ; Statement: specialinvoke $r120.<java.lang.StringBuilder: void <init>()>() 
(declare-const var500!1 String)
(assert (= var500!1 ""))
(assert true)
(define-const var3416 String (append/672562846 var500!1 "Need to specify the \u0027interfaceName\u0027 or \u0027interfaceClass\u0027 attribute of \u0027@DubboReference\u0027 if enable generic. ")) ; Statement: $r87 = virtualinvoke $r120.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Need to specify the \'interfaceName\' or \'interfaceClass\' attribute of \'@DubboReference\' if enable generic. ") 
(declare-const var500!2 String)
(assert (= var500!2 (str.++ var500!1 "Need to specify the \u0027interfaceName\u0027 or \u0027interfaceClass\u0027 attribute of \u0027@DubboReference\u0027 if enable generic. ")))
(assert true)
(define-const var2929 String (append/672562846 var3416 var1505)) ; Statement: $r88 = virtualinvoke $r87.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r90) 
(declare-const var3416!1 String)
(assert (= var3416!1 (str.++ var3416 var1505)))
(assert true)
(define-const var2261 String (toString/-2075883882 var2929)) ; Statement: $r89 = virtualinvoke $r88.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-2070561352 var1519 var2261)) ; Statement: specialinvoke $r121.<org.springframework.beans.factory.BeanCreationException: void <init>(java.lang.String)>($r89) 

(declare-const var1519!1 var735)
(declare-const var2261!1 String)
(define-const var3798 var2102 (cast-from-var735-to-var2102 var1519!1)) ; Statement: $r135 = (java.lang.Throwable) $r121 
 ; Statement: throw $r135 
(check-sat)
; {var32_getAttribute/147737434=([java.util.Map, java.lang.String], java.lang.Object), cast-from-var175-to-String=([java.lang.Object], java.lang.String), var3495_hasText/2115555376=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var175_toString/-522406933=([java.lang.Object], java.lang.String), cast-from-var2830-to-var175=([java.lang.reflect.Member], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2910_convertReferenceProps/-1256036247=([java.util.Map, java.lang.Class], void), var2821_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var175=([java.lang.String], java.lang.Object), var133_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var735-init=([], org.springframework.beans.factory.BeanCreationException), <init>/-2070561352=([org.springframework.beans.factory.BeanCreationException, java.lang.String], void), cast-from-var735-to-var2102=([org.springframework.beans.factory.BeanCreationException], java.lang.Throwable)}
; {var2186=org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor, var3813=r10, var2376=r2, var378=null_type, var1144=r8, var2821=java.util.Map, var219=r0, var2830=java.lang.reflect.Member, var586=r4, var433=z11, var175=java.lang.Object, var32=org.apache.dubbo.config.spring.util.AnnotationUtils, var1272=$r1, var2=r92, var3495=org.springframework.util.StringUtils, var1923=$z0, var3562=$r119, var1903=$r6, var237=$r5, var174=$r7, var1505=$r90, var2910=org.apache.dubbo.config.spring.reference.ReferenceBeanSupport, var3417=$r9, var91=$r91, var133=org.apache.dubbo.common.utils.StringUtils, var3190=$z1, var735=org.springframework.beans.factory.BeanCreationException, var1519=$r121, var500=$r120, var3416=$r87, var2929=$r88, var2261=$r89, var2102=java.lang.Throwable, var3798=$r135}
; {org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor=var2186, r10=var3813, r2=var2376, null_type=var378, r8=var1144, java.util.Map=var2821, r0=var219, java.lang.reflect.Member=var2830, r4=var586, z11=var433, java.lang.Object=var175, org.apache.dubbo.config.spring.util.AnnotationUtils=var32, $r1=var1272, r92=var2, org.springframework.util.StringUtils=var3495, $z0=var1923, $r119=var3562, $r6=var1903, $r5=var237, $r7=var174, $r90=var1505, org.apache.dubbo.config.spring.reference.ReferenceBeanSupport=var2910, $r9=var3417, $r91=var91, org.apache.dubbo.common.utils.StringUtils=var133, $z1=var3190, org.springframework.beans.factory.BeanCreationException=var735, $r121=var1519, $r120=var500, $r87=var3416, $r88=var2929, $r89=var2261, java.lang.Throwable=var2102, $r135=var3798}
;seq <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Object: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.springframework.util.StringUtils: boolean hasText(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r10 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor;	r2 := @parameter0: java.lang.String;	r8 := @parameter1: java.lang.Class;	r0 := @parameter2: java.util.Map;	r4 := @parameter3: java.lang.reflect.Member;	z11 = 1;	$r1 = staticinvoke <org.apache.dubbo.config.spring.util.AnnotationUtils: java.lang.Object getAttribute(java.util.Map,java.lang.String)>(r0, "id");	r92 = (java.lang.String) $r1;	$z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r92);	if $z0 == 0 goto r92 = r2;	z11 = 0;	goto [?= $r119 = new java.lang.StringBuilder];	$r119 = new java.lang.StringBuilder;	specialinvoke $r119.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r119.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Please check ");	$r5 = interfaceinvoke r4.<java.lang.reflect.Member: java.lang.String toString()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r90 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	staticinvoke <org.apache.dubbo.config.spring.reference.ReferenceBeanSupport: void convertReferenceProps(java.util.Map,java.lang.Class)>(r0, r8);	$r9 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface");	$r91 = (java.lang.String) $r9;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r91);	if $z1 == 0 goto $r11 = r10.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: org.springframework.context.ApplicationContext applicationContext>;	$r121 = new org.springframework.beans.factory.BeanCreationException;	$r120 = new java.lang.StringBuilder;	specialinvoke $r120.<java.lang.StringBuilder: void <init>()>();	$r87 = virtualinvoke $r120.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Need to specify the \'interfaceName\' or \'interfaceClass\' attribute of \'@DubboReference\' if enable generic. ");	$r88 = virtualinvoke $r87.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r90);	$r89 = virtualinvoke $r88.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r121.<org.springframework.beans.factory.BeanCreationException: void <init>(java.lang.String)>($r89);	$r135 = (java.lang.Throwable) $r121;	throw $r135
;block_num 4