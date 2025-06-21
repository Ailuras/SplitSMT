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

(declare-sort var3168 0)
(declare-sort var2648 0)
(declare-sort var2835 0)
(declare-sort var3178 0)
(declare-sort var1872 0)
(declare-sort var3331 0)
(declare-sort var3980 0)
(declare-sort var196 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun val2Index/-1887099830 (var3168) var2835)
(declare-fun toLowerCase/1946809429 (String var3178) String)
(declare-fun var2835_get/1088891777 (var2835 var1872) var1872)
(declare-fun cast-from-String-to-var1872 (String) var1872)
(declare-fun cast-from-var1872-to-Int (var1872) Int)
(declare-fun var3331-init () var3331)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun values/-1887099830 (var3168) (Array Int String))
(declare-fun var196_asList/1779083644 ((Array Int var1872)) var3980)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1872__ ((Array Int String)) (Array Int var1872))
(declare-fun append/-1031950772 (String var1872) String)
(declare-fun cast-from-var3980-to-var1872 (var3980) var1872)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var3331 String) void)
(declare-const null-var3168 var3168)
(declare-const null-String String)
(declare-const var3178-ROOT var3178)
(declare-const null-Int Int)
(declare-const var1849 var3168) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.param.FixedParamValue 
(assert (not (= var1849 null-var3168)))
(declare-const var3340 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3340 null-String)))
(define-const var51 var2835 (val2Index/-1887099830 var1849)) ; Statement: $r3 = r0.<org.apache.dubbo.common.url.component.param.FixedParamValue: java.util.Map val2Index> 
(define-const var2918 var3178 var3178-ROOT) ; Statement: $r2 = <java.util.Locale: java.util.Locale ROOT> 
(assert true)
(define-const var3503 String (toLowerCase/1946809429 var3340 var2918)) ; Statement: $r4 = virtualinvoke r1.<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>($r2) 
(define-const var571 var1872 (var2835_get/1088891777 var51 (cast-from-String-to-var1872 var3503))) ; Statement: $r5 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>($r4) 
(define-const var307 Int (cast-from-var1872-to-Int var571)) ; Statement: r6 = (java.lang.Integer) $r5 
 ; Statement: if r6 != null goto $i0 = virtualinvoke r6.<java.lang.Integer: int intValue()>() 
(assert (not (not (= var307 null-Int)))) ; Negate: Cond: r6 != null  
(define-const var948 var3331 var3331-init) ; Statement: $r7 = new java.lang.IllegalArgumentException 
(define-const var241 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var241)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var241!1 String)
(assert (= var241!1 ""))
(assert true)
(define-const var3227 String (append/672562846 var241!1 "unrecognized value ")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("unrecognized value ") 
(declare-const var241!2 String)
(assert (= var241!2 (str.++ var241!1 "unrecognized value ")))
(assert true)
(define-const var3723 String (append/672562846 var3227 var3340)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var3227!1 String)
(assert (= var3227!1 (str.++ var3227 var3340)))
(assert true)
(define-const var1296 String (append/672562846 var3723 " , please check if value is illegal. Permitted values: ")) ; Statement: $r13 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" , please check if value is illegal. Permitted values: ") 
(declare-const var3723!1 String)
(assert (= var3723!1 (str.++ var3723 " , please check if value is illegal. Permitted values: ")))
(define-const var864 (Array Int String) (values/-1887099830 var1849)) ; Statement: $r11 = r0.<org.apache.dubbo.common.url.component.param.FixedParamValue: java.lang.String[] values> 
(define-const var2120 var3980 (var196_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var1872__ var864))) ; Statement: $r12 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r11) 
(assert true)
(define-const var1758 String (append/-1031950772 var1296 (cast-from-var3980-to-var1872 var2120))) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r12) 
(declare-const var1296!1 String)
(assert (str.prefixof var1296 var1296!1))
(assert true)
(define-const var3187 String (toString/-2075883882 var1758)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var948 var3187)) ; Statement: specialinvoke $r7.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r15) 

(declare-const var948!1 var3331)
(declare-const var3187!1 String)
 ; Statement: throw $r7 
(check-sat)
; {val2Index/-1887099830=([org.apache.dubbo.common.url.component.param.FixedParamValue], java.util.Map), toLowerCase/1946809429=([java.lang.String, java.util.Locale], java.lang.String), var2835_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1872=([java.lang.String], java.lang.Object), cast-from-var1872-to-Int=([java.lang.Object], java.lang.Integer), var3331-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), values/-1887099830=([org.apache.dubbo.common.url.component.param.FixedParamValue], java.lang.String[]), var196_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var1872__=([java.lang.String[]], java.lang.Object[]), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3980-to-var1872=([java.util.List], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3168=org.apache.dubbo.common.url.component.param.FixedParamValue, var1849=r0, var3340=r1, var2648=null_type, var2835=java.util.Map, var51=$r3, var3178=java.util.Locale, var2918=$r2, var3503=$r4, var1872=java.lang.Object, var571=$r5, var307=r6, var3331=java.lang.IllegalArgumentException, var948=$r7, var241=$r8, var3227=$r9, var3723=$r10, var1296=$r13, var864=$r11, var3980=java.util.List, var196=java.util.Arrays, var2120=$r12, var1758=$r14, var3187=$r15}
; {org.apache.dubbo.common.url.component.param.FixedParamValue=var3168, r0=var1849, r1=var3340, null_type=var2648, java.util.Map=var2835, $r3=var51, java.util.Locale=var3178, $r2=var2918, $r4=var3503, java.lang.Object=var1872, $r5=var571, r6=var307, java.lang.IllegalArgumentException=var3331, $r7=var948, $r8=var241, $r9=var3227, $r10=var3723, $r13=var1296, $r11=var864, java.util.List=var3980, java.util.Arrays=var196, $r12=var2120, $r14=var1758, $r15=var3187}
;seq <java.lang.String: java.lang.String toLowerCase(java.util.Locale)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.param.FixedParamValue;	r1 := @parameter0: java.lang.String;	$r3 = r0.<org.apache.dubbo.common.url.component.param.FixedParamValue: java.util.Map val2Index>;	$r2 = <java.util.Locale: java.util.Locale ROOT>;	$r4 = virtualinvoke r1.<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>($r2);	$r5 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>($r4);	r6 = (java.lang.Integer) $r5;	if r6 != null goto $i0 = virtualinvoke r6.<java.lang.Integer: int intValue()>();	$r7 = new java.lang.IllegalArgumentException;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("unrecognized value ");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r13 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" , please check if value is illegal. Permitted values: ");	$r11 = r0.<org.apache.dubbo.common.url.component.param.FixedParamValue: java.lang.String[] values>;	$r12 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r11);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r7.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r15);	throw $r7
;block_num 2