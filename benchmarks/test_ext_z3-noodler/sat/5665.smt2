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

(declare-sort var401 0)
(declare-sort var1143 0)
(declare-sort var3364 0)
(declare-sort var1872 0)
(declare-sort var847 0)
(declare-sort var3001 0)
(declare-sort var3749 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun type/-1855590362 (var401) ClassObject)
(declare-fun isAssignableFrom/-1028998700 (ClassObject ClassObject) Bool)
(declare-fun var3001-init () var3001)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3749) String)
(declare-fun cast-from-ClassObject-to-var3749 (ClassObject) var3749)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var3001 String) void)
(declare-const null-var401 var401)
(declare-const null-var1143 var1143)
(declare-const null-var3364 var3364)
(declare-const null-var1872 var1872)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var650 var401) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var650 null-var401)))
(declare-const var884 var1143) ; Statement: r3 := @parameter0: java.lang.ClassLoader 
(assert (not (= var884 null-var1143)))
(declare-const var3442 var3364) ; Statement: r7 := @parameter1: java.util.Map 
(assert (not (= var3442 null-var3364)))
(declare-const var3795 var1872) ; Statement: r14 := @parameter2: java.net.URL 
(assert (not (= var3795 null-var1872)))
(declare-const var1450 ClassObject) ; Statement: r1 := @parameter3: java.lang.Class 
(assert (not (= var1450 null-ClassObject)))
(declare-const var3284 String) ; Statement: r31 := @parameter4: java.lang.String 
(assert (not (= var3284 null-String)))
(declare-const var3120 Bool) ; Statement: z6 := @parameter5: boolean 
(assert (not (= var3120 null-Bool)))
(define-const var915 ClassObject (type/-1855590362 var650)) ; Statement: $r2 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type> 
(assert true)
(define-const var2514 Bool (isAssignableFrom/-1028998700 var915 var1450)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>(r1) 
 ; Statement: if $z0 != 0 goto z1 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: boolean loadClassIfActive(java.lang.ClassLoader,java.lang.Class)>(r3, r1) 
(assert (not (not (= (ite var2514 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3827 var3001 var3001-init) ; Statement: $r18 = new java.lang.IllegalStateException 
(define-const var377 String String-init) ; Statement: $r19 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var377)) ; Statement: specialinvoke $r19.<java.lang.StringBuilder: void <init>()>() 
(declare-const var377!1 String)
(assert (= var377!1 ""))
(assert true)
(define-const var1254 String (append/672562846 var377!1 "Error occurred when loading extension class (interface: ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Error occurred when loading extension class (interface: ") 
(declare-const var377!2 String)
(assert (= var377!2 (str.++ var377!1 "Error occurred when loading extension class (interface: ")))
(define-const var1321 ClassObject (type/-1855590362 var650)) ; Statement: $r20 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type> 
(assert true)
(define-const var1288 String (append/-1031950772 var1254 (cast-from-ClassObject-to-var3749 var1321))) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20) 
(declare-const var1254!1 String)
(assert (str.prefixof var1254 var1254!1))
(assert true)
(define-const var1065 String (append/672562846 var1288 ", class line: ")) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", class line: ") 
(declare-const var1288!1 String)
(assert (= var1288!1 (str.++ var1288 ", class line: ")))
(assert true)
(define-const var2 String (getName/-1958580599 var1450)) ; Statement: $r23 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1622 String (append/672562846 var1065 var2)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23) 
(declare-const var1065!1 String)
(assert (= var1065!1 (str.++ var1065 var2)))
(assert true)
(define-const var3207 String (append/672562846 var1622 "), class ")) ; Statement: $r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("), class ") 
(declare-const var1622!1 String)
(assert (= var1622!1 (str.++ var1622 "), class ")))
(assert true)
(define-const var1366 String (getName/-1958580599 var1450)) ; Statement: $r26 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1414 String (append/672562846 var3207 var1366)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r26) 
(declare-const var3207!1 String)
(assert (= var3207!1 (str.++ var3207 var1366)))
(assert true)
(define-const var2630 String (append/672562846 var1414 " is not subtype of interface.")) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is not subtype of interface.") 
(declare-const var1414!1 String)
(assert (= var1414!1 (str.++ var1414 " is not subtype of interface.")))
(assert true)
(define-const var621 String (toString/-2075883882 var2630)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var3827 var621)) ; Statement: specialinvoke $r18.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r30) 

(declare-const var3827!1 var3001)
(declare-const var621!1 String)
 ; Statement: throw $r18 
(check-sat)
; {type/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Class), isAssignableFrom/-1028998700=([java.lang.Class, java.lang.Class], boolean), var3001-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var3749=([java.lang.Class], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var401=org.apache.dubbo.common.extension.ExtensionLoader, var650=r0, var1143=java.lang.ClassLoader, var884=r3, var3364=java.util.Map, var3442=r7, var1872=java.net.URL, var3795=r14, var1450=r1, var3284=r31, var847=null_type, var3120=z6, var915=$r2, var2514=$z0, var3001=java.lang.IllegalStateException, var3827=$r18, var377=$r19, var1254=$r21, var1321=$r20, var3749=java.lang.Object, var1288=$r22, var1065=$r24, var2=$r23, var1622=$r25, var3207=$r27, var1366=$r26, var1414=$r28, var2630=$r29, var621=$r30}
; {org.apache.dubbo.common.extension.ExtensionLoader=var401, r0=var650, java.lang.ClassLoader=var1143, r3=var884, java.util.Map=var3364, r7=var3442, java.net.URL=var1872, r14=var3795, r1=var1450, r31=var3284, null_type=var847, z6=var3120, $r2=var915, $z0=var2514, java.lang.IllegalStateException=var3001, $r18=var3827, $r19=var377, $r21=var1254, $r20=var1321, java.lang.Object=var3749, $r22=var1288, $r24=var1065, $r23=var2, $r25=var1622, $r27=var3207, $r26=var1366, $r28=var1414, $r29=var2630, $r30=var621}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r3 := @parameter0: java.lang.ClassLoader;	r7 := @parameter1: java.util.Map;	r14 := @parameter2: java.net.URL;	r1 := @parameter3: java.lang.Class;	r31 := @parameter4: java.lang.String;	z6 := @parameter5: boolean;	$r2 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type>;	$z0 = virtualinvoke $r2.<java.lang.Class: boolean isAssignableFrom(java.lang.Class)>(r1);	if $z0 != 0 goto z1 = specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: boolean loadClassIfActive(java.lang.ClassLoader,java.lang.Class)>(r3, r1);	$r18 = new java.lang.IllegalStateException;	$r19 = new java.lang.StringBuilder;	specialinvoke $r19.<java.lang.StringBuilder: void <init>()>();	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Error occurred when loading extension class (interface: ");	$r20 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type>;	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20);	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", class line: ");	$r23 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>();	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23);	$r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("), class ");	$r26 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>();	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r26);	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is not subtype of interface.");	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r18.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r30);	throw $r18
;block_num 2