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

(declare-sort var3648 0)
(declare-sort var3358 0)
(declare-sort var2284 0)
(declare-sort var3650 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun destroyed/-1855590362 (var3648) var3358)
(declare-fun get/2135855162 (var3358) Bool)
(declare-fun var2284-init () var2284)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun type/-1855590362 (var3648) ClassObject)
(declare-fun append/-1031950772 (String var3650) String)
(declare-fun cast-from-ClassObject-to-var3650 (ClassObject) var3650)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var2284 String) void)
(declare-const null-var3648 var3648)
(declare-const var812 var3648) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var812 null-var3648)))
(define-const var2528 var3358 (destroyed/-1855590362 var812)) ; Statement: $r1 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.concurrent.atomic.AtomicBoolean destroyed> 
(assert true)
(define-const var1839 Bool (get/2135855162 var2528)) ; Statement: $z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>() 
 ; Statement: if $z0 == 0 goto return 
(assert (not (= (ite var1839 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2866 var2284 var2284-init) ; Statement: $r2 = new java.lang.IllegalStateException 
(define-const var1587 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1587)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1587!1 String)
(assert (= var1587!1 ""))
(assert true)
(define-const var1823 String (append/672562846 var1587!1 "ExtensionLoader is destroyed: ")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ExtensionLoader is destroyed: ") 
(declare-const var1587!2 String)
(assert (= var1587!2 (str.++ var1587!1 "ExtensionLoader is destroyed: ")))
(define-const var3309 ClassObject (type/-1855590362 var812)) ; Statement: $r4 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type> 
(assert true)
(define-const var1063 String (append/-1031950772 var1823 (cast-from-ClassObject-to-var3650 var3309))) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4) 
(declare-const var1823!1 String)
(assert (str.prefixof var1823 var1823!1))
(assert true)
(define-const var3054 String (toString/-2075883882 var1063)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var2866 var3054)) ; Statement: specialinvoke $r2.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r7) 

(declare-const var2866!1 var2284)
(declare-const var3054!1 String)
 ; Statement: throw $r2 
(check-sat)
; {destroyed/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.util.concurrent.atomic.AtomicBoolean), get/2135855162=([java.util.concurrent.atomic.AtomicBoolean], boolean), var2284-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), type/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var3650=([java.lang.Class], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var3648=org.apache.dubbo.common.extension.ExtensionLoader, var812=r0, var3358=java.util.concurrent.atomic.AtomicBoolean, var2528=$r1, var1839=$z0, var2284=java.lang.IllegalStateException, var2866=$r2, var1587=$r3, var1823=$r5, var3309=$r4, var3650=java.lang.Object, var1063=$r6, var3054=$r7}
; {org.apache.dubbo.common.extension.ExtensionLoader=var3648, r0=var812, java.util.concurrent.atomic.AtomicBoolean=var3358, $r1=var2528, $z0=var1839, java.lang.IllegalStateException=var2284, $r2=var2866, $r3=var1587, $r5=var1823, $r4=var3309, java.lang.Object=var3650, $r6=var1063, $r7=var3054}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	$r1 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.concurrent.atomic.AtomicBoolean destroyed>;	$z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>();	if $z0 == 0 goto return;	$r2 = new java.lang.IllegalStateException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ExtensionLoader is destroyed: ");	$r4 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r7);	throw $r2
;block_num 2