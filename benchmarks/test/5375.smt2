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

(declare-sort var2273 0)
(declare-sort var3047 0)
(declare-sort var2824 0)
(declare-sort var1516 0)
(declare-sort var1385 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3047-init () var3047)
(declare-fun <init>/-325640736 (var3047) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun interfaceName/2049477907 (var2824) String)
(declare-fun cast-from-var2273-to-var2824 (var2273) var2824)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1516_add/328494887 (var1516 var1385) Bool)
(declare-fun cast-from-var3047-to-var1516 (var3047) var1516)
(declare-fun cast-from-String-to-var1385 (String) var1385)
(declare-const null-var2273 var2273)
(declare-const var1332 var2273) ; Statement: r2 := @this: org.apache.dubbo.config.ReferenceConfigBase 
(assert (not (= var1332 null-var2273)))
(define-const var1036 var3047 var3047-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1036)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var1036!1 var3047)
(define-const var2482 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2482)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2482!1 String)
(assert (= var2482!1 ""))
(assert true)
(define-const var1929 String (append/672562846 var2482!1 "dubbo.reference.")) ; Statement: $r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo.reference.") 
(declare-const var2482!2 String)
(assert (= var2482!2 (str.++ var2482!1 "dubbo.reference.")))
(define-const var2131 String (interfaceName/2049477907 (cast-from-var2273-to-var2824 var1332))) ; Statement: $r3 = r2.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String interfaceName> 
(assert true)
(define-const var3987 String (append/672562846 var1929 var2131)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1929!1 String)
(assert (= var1929!1 (str.++ var1929 var2131)))
(assert true)
(define-const var3290 String (toString/-2075883882 var3987)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1516_add/328494887 (cast-from-var3047-to-var1516 var1036!1) (cast-from-String-to-var1385 var3290))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r6) 

(declare-const var1036!2 var3047)
(declare-const var3290!1 String)
 ; Statement: return $r0 
(check-sat)
; {var3047-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), interfaceName/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), cast-from-var2273-to-var2824=([org.apache.dubbo.config.ReferenceConfigBase], org.apache.dubbo.config.AbstractInterfaceConfig), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1516_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var3047-to-var1516=([java.util.ArrayList], java.util.List), cast-from-String-to-var1385=([java.lang.String], java.lang.Object)}
; {var2273=org.apache.dubbo.config.ReferenceConfigBase, var1332=r2, var3047=java.util.ArrayList, var1036=$r0, var2482=$r1, var1929=$r4, var2824=org.apache.dubbo.config.AbstractInterfaceConfig, var2131=$r3, var3987=$r5, var3290=$r6, var1516=java.util.List, var1385=java.lang.Object}
; {org.apache.dubbo.config.ReferenceConfigBase=var2273, r2=var1332, java.util.ArrayList=var3047, $r0=var1036, $r1=var2482, $r4=var1929, org.apache.dubbo.config.AbstractInterfaceConfig=var2824, $r3=var2131, $r5=var3987, $r6=var3290, java.util.List=var1516, java.lang.Object=var1385}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.config.ReferenceConfigBase;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo.reference.");	$r3 = r2.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String interfaceName>;	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r6);	return $r0
;block_num 1