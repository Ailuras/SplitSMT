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

(declare-sort var323 0)
(declare-sort var2114 0)
(declare-sort var3706 0)
(declare-sort var2409 0)
(declare-sort var3453 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun parentPrefix/50586633 (var323) String)
(declare-fun var3706-init () var3706)
(declare-fun <init>/-325640736 (var3706) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/824650316 (var323) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2409_add/328494887 (var2409 var3453) Bool)
(declare-fun cast-from-var3706-to-var2409 (var3706) var2409)
(declare-fun cast-from-String-to-var3453 (String) var3453)
(declare-const null-var323 var323)
(declare-const null-String String)
(declare-const var187 var323) ; Statement: r0 := @this: org.apache.dubbo.config.MethodConfig 
(assert (not (= var187 null-var323)))
(define-const var1201 String (parentPrefix/50586633 var187)) ; Statement: $r1 = r0.<org.apache.dubbo.config.MethodConfig: java.lang.String parentPrefix> 
 ; Statement: if $r1 == null goto return null 
(assert (not (= var1201 null-String))) ; Negate: Cond: $r1 == null  
(define-const var2896 var3706 var3706-init) ; Statement: $r2 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2896)) ; Statement: specialinvoke $r2.<java.util.ArrayList: void <init>()>() 

(declare-const var2896!1 var3706)
(define-const var3305 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3305)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3305!1 String)
(assert (= var3305!1 ""))
(define-const var2583 String (parentPrefix/50586633 var187)) ; Statement: $r4 = r0.<org.apache.dubbo.config.MethodConfig: java.lang.String parentPrefix> 
(assert true)
(define-const var209 String (append/672562846 var3305!1 var2583)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var3305!2 String)
(assert (= var3305!2 (str.++ var3305!1 var2583)))
(assert true)
(define-const var1233 String (append/672562846 var209 ".")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var209!1 String)
(assert (= var209!1 (str.++ var209 ".")))
(assert true)
(define-const var3763 String (getName/824650316 var187)) ; Statement: $r6 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.lang.String getName()>() 
(assert true)
(define-const var3543 String (append/672562846 var1233 var3763)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1233!1 String)
(assert (= var1233!1 (str.++ var1233 var3763)))
(assert true)
(define-const var747 String (toString/-2075883882 var3543)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2409_add/328494887 (cast-from-var3706-to-var2409 var2896!1) (cast-from-String-to-var3453 var747))) ; Statement: interfaceinvoke $r2.<java.util.List: boolean add(java.lang.Object)>($r9) 

(declare-const var2896!2 var3706)
(declare-const var747!1 String)
 ; Statement: return $r2 
(check-sat)
; {parentPrefix/50586633=([org.apache.dubbo.config.MethodConfig], java.lang.String), var3706-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/824650316=([org.apache.dubbo.config.MethodConfig], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2409_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var3706-to-var2409=([java.util.ArrayList], java.util.List), cast-from-String-to-var3453=([java.lang.String], java.lang.Object)}
; {var323=org.apache.dubbo.config.MethodConfig, var187=r0, var1201=$r1, var2114=null_type, var3706=java.util.ArrayList, var2896=$r2, var3305=$r3, var2583=$r4, var209=$r5, var1233=$r7, var3763=$r6, var3543=$r8, var747=$r9, var2409=java.util.List, var3453=java.lang.Object}
; {org.apache.dubbo.config.MethodConfig=var323, r0=var187, $r1=var1201, null_type=var2114, java.util.ArrayList=var3706, $r2=var2896, $r3=var3305, $r4=var2583, $r5=var209, $r7=var1233, $r6=var3763, $r8=var3543, $r9=var747, java.util.List=var2409, java.lang.Object=var3453}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.MethodConfig;	$r1 = r0.<org.apache.dubbo.config.MethodConfig: java.lang.String parentPrefix>;	if $r1 == null goto return null;	$r2 = new java.util.ArrayList;	specialinvoke $r2.<java.util.ArrayList: void <init>()>();	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = r0.<org.apache.dubbo.config.MethodConfig: java.lang.String parentPrefix>;	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r6 = virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: java.lang.String getName()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r2.<java.util.List: boolean add(java.lang.Object)>($r9);	return $r2
;block_num 2