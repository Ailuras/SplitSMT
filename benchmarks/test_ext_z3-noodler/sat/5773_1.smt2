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

(declare-sort var2531 0)
(declare-sort var3495 0)
(declare-sort var2039 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isInterface/-352192428 (ClassObject) Bool)
(declare-fun var3495-init () var3495)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var2039) String)
(declare-fun cast-from-ClassObject-to-var2039 (ClassObject) var2039)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var3495 String) void)
(declare-const null-var2531 var2531)
(declare-const null-ClassObject ClassObject)
(declare-const var1087 var2531) ; Statement: r1 := @this: org.apache.dubbo.config.ReferenceConfigBase 
(assert (not (= var1087 null-var2531)))
(declare-const var887 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var887 null-ClassObject)))
 ; Statement: if r0 == null goto (branch) 
(assert (not (= var887 null-ClassObject))) ; Negate: Cond: r0 == null  
(assert true)
(define-const var2989 Bool (isInterface/-352192428 var887)) ; Statement: $z1 = virtualinvoke r0.<java.lang.Class: boolean isInterface()>() 
 ; Statement: if $z1 != 0 goto (branch) 
(assert (not (not (= (ite var2989 1 0) 0)))) ; Negate: Cond: $z1 != 0  
(define-const var3006 var3495 var3495-init) ; Statement: $r7 = new java.lang.IllegalStateException 
(define-const var2628 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2628)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2628!1 String)
(assert (= var2628!1 ""))
(assert true)
(define-const var2025 String (append/672562846 var2628!1 "The interface class ")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The interface class ") 
(declare-const var2628!2 String)
(assert (= var2628!2 (str.++ var2628!1 "The interface class ")))
(assert true)
(define-const var651 String (append/-1031950772 var2025 (cast-from-ClassObject-to-var2039 var887))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var2025!1 String)
(assert (str.prefixof var2025 var2025!1))
(assert true)
(define-const var3308 String (append/672562846 var651 " is not a interface!")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is not a interface!") 
(declare-const var651!1 String)
(assert (= var651!1 (str.++ var651 " is not a interface!")))
(assert true)
(define-const var3463 String (toString/-2075883882 var3308)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var3006 var3463)) ; Statement: specialinvoke $r7.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r12) 

(declare-const var3006!1 var3495)
(declare-const var3463!1 String)
 ; Statement: throw $r7 
(check-sat)
; {isInterface/-352192428=([java.lang.Class], boolean), var3495-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var2039=([java.lang.Class], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var2531=org.apache.dubbo.config.ReferenceConfigBase, var1087=r1, var887=r0, var2989=$z1, var3495=java.lang.IllegalStateException, var3006=$r7, var2628=$r8, var2025=$r9, var2039=java.lang.Object, var651=$r10, var3308=$r11, var3463=$r12}
; {org.apache.dubbo.config.ReferenceConfigBase=var2531, r1=var1087, r0=var887, $z1=var2989, java.lang.IllegalStateException=var3495, $r7=var3006, $r8=var2628, $r9=var2025, java.lang.Object=var2039, $r10=var651, $r11=var3308, $r12=var3463}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.config.ReferenceConfigBase;	r0 := @parameter0: java.lang.Class;	if r0 == null goto (branch);	$z1 = virtualinvoke r0.<java.lang.Class: boolean isInterface()>();	if $z1 != 0 goto (branch);	$r7 = new java.lang.IllegalStateException;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The interface class ");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is not a interface!");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r7.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r12);	throw $r7
;block_num 3