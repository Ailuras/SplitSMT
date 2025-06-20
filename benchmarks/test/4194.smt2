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

(declare-sort var363 0)
(declare-sort var1272 0)
(declare-sort var2912 0)
(declare-sort var1485 0)
(declare-sort var2651 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkDestroyed/-625758128 (var363) void)
(declare-fun cachedAdaptiveInstance/-1855590362 (var363) var1272)
(declare-fun get/1014414220 (var1272) var2912)
(declare-fun createAdaptiveInstanceError/-1855590362 (var363) var1485)
(declare-fun var2651-init () var2651)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun toString/-1112415476 (var1485) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1447874194 (var2651 String var1485) void)
(declare-const null-var363 var363)
(declare-const null-var2912 var2912)
(declare-const null-var1485 var1485)
(declare-const var3299 var363) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var3299 null-var363)))
(assert true)
;(assert (checkDestroyed/-625758128 var3299)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>() 

(declare-const var3299!1 var363)
(define-const var3161 var1272 (cachedAdaptiveInstance/-1855590362 var3299!1)) ; Statement: $r1 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.utils.Holder cachedAdaptiveInstance> 
(assert true)
(define-const var790 var2912 (get/1014414220 var3161)) ; Statement: r22 = virtualinvoke $r1.<org.apache.dubbo.common.utils.Holder: java.lang.Object get()>() 
 ; Statement: if r22 != null goto return r22 
(assert (not (not (= var790 null-var2912)))) ; Negate: Cond: r22 != null  
(define-const var75 var1485 (createAdaptiveInstanceError/-1855590362 var3299!1)) ; Statement: $r2 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Throwable createAdaptiveInstanceError> 
 ; Statement: if $r2 == null goto $r3 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.utils.Holder cachedAdaptiveInstance> 
(assert (not (= var75 null-var1485))) ; Negate: Cond: $r2 == null  
(define-const var3228 var2651 var2651-init) ; Statement: $r6 = new java.lang.IllegalStateException 
(define-const var2672 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2672)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2672!1 String)
(assert (= var2672!1 ""))
(assert true)
(define-const var2601 String (append/672562846 var2672!1 "Failed to create adaptive instance: ")) ; Statement: $r10 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to create adaptive instance: ") 
(declare-const var2672!2 String)
(assert (= var2672!2 (str.++ var2672!1 "Failed to create adaptive instance: ")))
(define-const var2994 var1485 (createAdaptiveInstanceError/-1855590362 var3299!1)) ; Statement: $r8 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Throwable createAdaptiveInstanceError> 
(assert true)
(define-const var3683 String (toString/-1112415476 var2994)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.Throwable: java.lang.String toString()>() 
(assert true)
(define-const var3706 String (append/672562846 var2601 var3683)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var2601!1 String)
(assert (= var2601!1 (str.++ var2601 var3683)))
(assert true)
(define-const var3524 String (toString/-2075883882 var3706)) ; Statement: $r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1103 var1485 (createAdaptiveInstanceError/-1855590362 var3299!1)) ; Statement: $r12 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Throwable createAdaptiveInstanceError> 
(assert true)
;(assert (<init>/-1447874194 var3228 var3524 var1103)) ; Statement: specialinvoke $r6.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r13, $r12) 

(declare-const var3228!1 var2651)
(declare-const var3524!1 String)
(declare-const var1103!1 var1485)
 ; Statement: throw $r6 
(check-sat)
; {checkDestroyed/-625758128=([org.apache.dubbo.common.extension.ExtensionLoader], void), cachedAdaptiveInstance/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], org.apache.dubbo.common.utils.Holder), get/1014414220=([org.apache.dubbo.common.utils.Holder], java.lang.Object), createAdaptiveInstanceError/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Throwable), var2651-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-1112415476=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var363=org.apache.dubbo.common.extension.ExtensionLoader, var3299=r0, var1272=org.apache.dubbo.common.utils.Holder, var3161=$r1, var2912=java.lang.Object, var790=r22, var1485=java.lang.Throwable, var75=$r2, var2651=java.lang.IllegalStateException, var3228=$r6, var2672=$r7, var2601=$r10, var2994=$r8, var3683=$r9, var3706=$r11, var3524=$r13, var1103=$r12}
; {org.apache.dubbo.common.extension.ExtensionLoader=var363, r0=var3299, org.apache.dubbo.common.utils.Holder=var1272, $r1=var3161, java.lang.Object=var2912, r22=var790, java.lang.Throwable=var1485, $r2=var75, java.lang.IllegalStateException=var2651, $r6=var3228, $r7=var2672, $r10=var2601, $r8=var2994, $r9=var3683, $r11=var3706, $r13=var3524, $r12=var1103}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Throwable: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	specialinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: void checkDestroyed()>();	$r1 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.utils.Holder cachedAdaptiveInstance>;	r22 = virtualinvoke $r1.<org.apache.dubbo.common.utils.Holder: java.lang.Object get()>();	if r22 != null goto return r22;	$r2 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Throwable createAdaptiveInstanceError>;	if $r2 == null goto $r3 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.utils.Holder cachedAdaptiveInstance>;	$r6 = new java.lang.IllegalStateException;	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to create adaptive instance: ");	$r8 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Throwable createAdaptiveInstanceError>;	$r9 = virtualinvoke $r8.<java.lang.Throwable: java.lang.String toString()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	$r12 = r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Throwable createAdaptiveInstanceError>;	specialinvoke $r6.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r13, $r12);	throw $r6
;block_num 3