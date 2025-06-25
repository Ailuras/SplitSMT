(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2653 0)
(declare-sort var200 0)
(declare-sort var136 0)
(declare-sort var2037 0)
(declare-sort var129 0)
(declare-sort var455 0)
(declare-sort var1897 0)
(declare-sort var3673 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2037-init () var2037)
(declare-fun <init>/-325640736 (var2037) void)
(declare-fun var136_get/1088891777 (var136 var129) var129)
(declare-fun cast-from-String-to-var129 (String) var129)
(declare-fun cast-from-var129-to-String (var129) String)
(declare-fun var1897_asList/1779083644 ((Array Int var129)) var455)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var129__ ((Array Int String)) (Array Int var129))
(declare-fun var455_addAll/-525367613 (var455 var3673) Bool)
(declare-fun cast-from-var2037-to-var455 (var2037) var455)
(declare-fun cast-from-var455-to-var3673 (var455) var3673)
(declare-const null-var2653 var2653)
(declare-const null-String String)
(declare-const null-var136 var136)
(declare-const var3664 var2653) ; Statement: r17 := @this: org.jline.console.impl.DefaultPrinter 
(assert (not (= var3664 null-var2653)))
(declare-const var1696 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1696 null-String)))
(declare-const var1818 var136) ; Statement: r1 := @parameter1: java.util.Map 
(assert (not (= var1818 null-var136)))
(define-const var2143 var2037 var2037-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2143)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var2143!1 var2037)
(define-const var38 var129 (var136_get/1088891777 var1818 (cast-from-String-to-var129 var1696))) ; Statement: r3 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2) 
(define-const var1149 Bool false) ; Statement: $z0 = r3 instanceof java.lang.String 
 ; Statement: if $z0 == 0 goto $z1 = r3 instanceof java.util.Collection 
(assert (not (= (ite var1149 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2015 String (cast-from-var129-to-String var38)) ; Statement: $r14 = (java.lang.String) r3 
; split operation: var120 = var2015.split(",") ; Statement: $r15 = virtualinvoke $r14.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var1143 var455 (var1897_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var129__ var120))) ; Statement: $r16 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r15) 
;(assert (var455_addAll/-525367613 (cast-from-var2037-to-var455 var2143!1) (cast-from-var455-to-var3673 var1143))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean addAll(java.util.Collection)>($r16) 

(declare-const var2143!2 var2037)
(declare-const var1143!1 var455)
 ; Statement: goto [?= return $r0] 
(assert true) ; Non Conditional
 ; Statement: return $r0 
(check-sat)
; {var2037-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var136_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var129=([java.lang.String], java.lang.Object), cast-from-var129-to-String=([java.lang.Object], java.lang.String), var1897_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var129__=([java.lang.String[]], java.lang.Object[]), var455_addAll/-525367613=([java.util.List, java.util.Collection], boolean), cast-from-var2037-to-var455=([java.util.ArrayList], java.util.List), cast-from-var455-to-var3673=([java.util.List], java.util.Collection)}
; {var2653=org.jline.console.impl.DefaultPrinter, var3664=r17, var1696=r2, var200=null_type, var136=java.util.Map, var1818=r1, var2037=java.util.ArrayList, var2143=$r0, var129=java.lang.Object, var38=r3, var1149=$z0, var2015=$r14, var120=$r15, var455=java.util.List, var1897=java.util.Arrays, var1143=$r16, var3673=java.util.Collection}
; {org.jline.console.impl.DefaultPrinter=var2653, r17=var3664, r2=var1696, null_type=var200, java.util.Map=var136, r1=var1818, java.util.ArrayList=var2037, $r0=var2143, java.lang.Object=var129, r3=var38, $z0=var1149, $r14=var2015, $r15=var120, java.util.List=var455, java.util.Arrays=var1897, $r16=var1143, java.util.Collection=var3673}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r17 := @this: org.jline.console.impl.DefaultPrinter;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.util.Map;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	r3 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2);	$z0 = r3 instanceof java.lang.String;	if $z0 == 0 goto $z1 = r3 instanceof java.util.Collection;	$r14 = (java.lang.String) r3;	$r15 = virtualinvoke $r14.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r16 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r15);	interfaceinvoke $r0.<java.util.List: boolean addAll(java.util.Collection)>($r16);	goto [?= return $r0];	return $r0
;block_num 3