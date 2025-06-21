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

(declare-sort var1452 0)
(declare-sort var3134 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var3134) ClassObject)
(declare-fun cast-from-var1452-to-var3134 (var1452) var3134)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun type/-1855590362 (var1452) ClassObject)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1452 var1452)
(declare-const var1749 var1452) ; Statement: r1 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var1749 null-var1452)))
(define-const var2683 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2683)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2683!1 String)
(assert (= var2683!1 ""))
(assert true)
(define-const var2312 ClassObject (getClass/1258963082 (cast-from-var1452-to-var3134 var1749))) ; Statement: $r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var3182 String (getName/-1958580599 var2312)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var385 String (append/672562846 var2683!1 var3182)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2683!2 String)
(assert (= var2683!2 (str.++ var2683!1 var3182)))
(assert true)
(define-const var2978 String (append/672562846 var385 "[")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var385!1 String)
(assert (= var385!1 (str.++ var385 "[")))
(define-const var2678 ClassObject (type/-1855590362 var1749)) ; Statement: $r5 = r1.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type> 
(assert true)
(define-const var3686 String (getName/-1958580599 var2678)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3458 String (append/672562846 var2978 var3686)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2978!1 String)
(assert (= var2978!1 (str.++ var2978 var3686)))
(assert true)
(define-const var2773 String (append/672562846 var3458 "]")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var3458!1 String)
(assert (= var3458!1 (str.++ var3458 "]")))
(assert true)
(define-const var1794 String (toString/-2075883882 var2773)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var1452-to-var3134=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), type/-1855590362=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Class), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1452=org.apache.dubbo.common.extension.ExtensionLoader, var1749=r1, var2683=$r0, var3134=java.lang.Object, var2312=$r2, var3182=$r3, var385=$r4, var2978=$r7, var2678=$r5, var3686=$r6, var3458=$r8, var2773=$r9, var1794=$r10}
; {org.apache.dubbo.common.extension.ExtensionLoader=var1452, r1=var1749, $r0=var2683, java.lang.Object=var3134, $r2=var2312, $r3=var3182, $r4=var385, $r7=var2978, $r5=var2678, $r6=var3686, $r8=var3458, $r9=var2773, $r10=var1794}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r5 = r1.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Class type>;	$r6 = virtualinvoke $r5.<java.lang.Class: java.lang.String getName()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 1