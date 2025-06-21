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

(declare-sort var3545 0)
(declare-sort var3957 0)
(declare-sort var3856 0)
(declare-sort var1277 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-461383052 (var3856) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3957_put/1464166817 (var3957 var1277 var1277) var1277)
(declare-fun cast-from-String-to-var1277 (String) var1277)
(declare-fun cast-from-var3856-to-var1277 (var3856) var1277)
(declare-const null-String String)
(declare-const null-var3957 var3957)
(declare-const null-var3856 var3856)
(declare-const var3420 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var3420 null-String)))
(declare-const var1756 var3957) ; Statement: r1 := @parameter1: java.util.Map 
(assert (not (= var1756 null-var3957)))
(declare-const var1301 var3856) ; Statement: r0 := @parameter2: org.springframework.core.env.PropertySource 
(assert (not (= var1301 null-var3856)))
(define-const var1421 Bool true) ; Statement: $z0 = r0 instanceof org.springframework.core.env.CompositePropertySource 
 ; Statement: if $z0 == 0 goto $r2 = new java.lang.StringBuilder 
(assert (= (ite var1421 1 0) 0)) ; Cond: $z0 == 0 
(define-const var585 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var585)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var585!1 String)
(assert (= var585!1 ""))
(assert true)
(define-const var187 String (append/672562846 var585!1 var3420)) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var585!2 String)
(assert (= var585!2 (str.++ var585!1 var3420)))
(assert true)
(define-const var1729 String (getName/-461383052 var1301)) ; Statement: $r4 = virtualinvoke r0.<org.springframework.core.env.PropertySource: java.lang.String getName()>() 
(assert true)
(define-const var3977 String (append/672562846 var187 var1729)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var187!1 String)
(assert (= var187!1 (str.++ var187 var1729)))
(assert true)
(define-const var2102 String (toString/-2075883882 var3977)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3957_put/1464166817 var1756 (cast-from-String-to-var1277 var2102) (cast-from-var3856-to-var1277 var1301))) ; Statement: interfaceinvoke r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r7, r0) 

(declare-const var1756!1 var3957)
(declare-const var2102!1 String)
(declare-const var1301!1 var3856)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-461383052=([org.springframework.core.env.PropertySource], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3957_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var1277=([java.lang.String], java.lang.Object), cast-from-var3856-to-var1277=([org.springframework.core.env.PropertySource], java.lang.Object)}
; {var3420=r3, var3545=null_type, var3957=java.util.Map, var1756=r1, var3856=org.springframework.core.env.PropertySource, var1301=r0, var1421=$z0, var585=$r2, var187=$r5, var1729=$r4, var3977=$r6, var2102=$r7, var1277=java.lang.Object}
; {r3=var3420, null_type=var3545, java.util.Map=var3957, r1=var1756, org.springframework.core.env.PropertySource=var3856, r0=var1301, $z0=var1421, $r2=var585, $r5=var187, $r4=var1729, $r6=var3977, $r7=var2102, java.lang.Object=var1277}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @parameter0: java.lang.String;	r1 := @parameter1: java.util.Map;	r0 := @parameter2: org.springframework.core.env.PropertySource;	$z0 = r0 instanceof org.springframework.core.env.CompositePropertySource;	if $z0 == 0 goto $r2 = new java.lang.StringBuilder;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r4 = virtualinvoke r0.<org.springframework.core.env.PropertySource: java.lang.String getName()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r7, r0);	return
;block_num 3