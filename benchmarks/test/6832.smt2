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

(declare-sort var1314 0)
(declare-sort var2343 0)
(declare-sort var2431 0)
(declare-sort var745 0)
(declare-sort var2032 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2343-init () var2343)
(declare-fun <init>/-325640736 (var2343) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun interfaceName/2049477907 (var2431) String)
(declare-fun cast-from-var1314-to-var2431 (var1314) var2431)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var745_add/328494887 (var745 var2032) Bool)
(declare-fun cast-from-var2343-to-var745 (var2343) var745)
(declare-fun cast-from-String-to-var2032 (String) var2032)
(declare-const null-var1314 var1314)
(declare-const var1430 var1314) ; Statement: r2 := @this: org.apache.dubbo.config.ServiceConfigBase 
(assert (not (= var1430 null-var1314)))
(define-const var3606 var2343 var2343-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var3606)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var3606!1 var2343)
(define-const var1285 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1285)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1285!1 String)
(assert (= var1285!1 ""))
(assert true)
(define-const var2750 String (append/672562846 var1285!1 "dubbo.service.")) ; Statement: $r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo.service.") 
(declare-const var1285!2 String)
(assert (= var1285!2 (str.++ var1285!1 "dubbo.service.")))
(define-const var1432 String (interfaceName/2049477907 (cast-from-var1314-to-var2431 var1430))) ; Statement: $r3 = r2.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String interfaceName> 
(assert true)
(define-const var999 String (append/672562846 var2750 var1432)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2750!1 String)
(assert (= var2750!1 (str.++ var2750 var1432)))
(assert true)
(define-const var1257 String (toString/-2075883882 var999)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var745_add/328494887 (cast-from-var2343-to-var745 var3606!1) (cast-from-String-to-var2032 var1257))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r6) 

(declare-const var3606!2 var2343)
(declare-const var1257!1 String)
 ; Statement: return $r0 
(check-sat)
; {var2343-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), interfaceName/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), cast-from-var1314-to-var2431=([org.apache.dubbo.config.ServiceConfigBase], org.apache.dubbo.config.AbstractInterfaceConfig), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var745_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var2343-to-var745=([java.util.ArrayList], java.util.List), cast-from-String-to-var2032=([java.lang.String], java.lang.Object)}
; {var1314=org.apache.dubbo.config.ServiceConfigBase, var1430=r2, var2343=java.util.ArrayList, var3606=$r0, var1285=$r1, var2750=$r4, var2431=org.apache.dubbo.config.AbstractInterfaceConfig, var1432=$r3, var999=$r5, var1257=$r6, var745=java.util.List, var2032=java.lang.Object}
; {org.apache.dubbo.config.ServiceConfigBase=var1314, r2=var1430, java.util.ArrayList=var2343, $r0=var3606, $r1=var1285, $r4=var2750, org.apache.dubbo.config.AbstractInterfaceConfig=var2431, $r3=var1432, $r5=var999, $r6=var1257, java.util.List=var745, java.lang.Object=var2032}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.config.ServiceConfigBase;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo.service.");	$r3 = r2.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String interfaceName>;	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r6);	return $r0
;block_num 1