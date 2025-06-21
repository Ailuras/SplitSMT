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

(declare-sort var2699 0)
(declare-sort var1072 0)
(declare-sort var2304 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var1072_containsKey/1715618542 (var1072 var2699) Bool)
(declare-fun cast-from-__Array__Int__var2699__-to-var2699 ((Array Int var2699)) var2699)
(declare-fun var1072_put/1464166817 (var1072 var2699 var2699) var2699)
(declare-fun getLength-Arr-var2699-1 ((Array Int var2699)) Int)
(declare-fun var1072_remove/-1201052315 (var1072 var2699) var2699)
(declare-const null-String String)
(declare-const null-__Array__Int__var2699__ (Array Int var2699))
(declare-const null-var1072 var1072)
(declare-const null-var2699 var2699)
(declare-const var3778 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var3778 null-String)))
(declare-const var3698 (Array Int var2699)) ; Statement: r2 := @parameter1: java.lang.Object[] 
(assert (not (= var3698 null-__Array__Int__var2699__)))
(declare-const var37 var1072) ; Statement: r1 := @parameter2: java.util.Map 
(assert (not (= var37 null-var1072)))
(assert true)
;(assert (append/-1166366385 var3778 91)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(91) 
(declare-const var3778!1 String)
(assert (str.prefixof var3778 var3778!1))
(define-const var188 Bool (var1072_containsKey/1715618542 var37 (cast-from-__Array__Int__var2699__-to-var2699 var3698))) ; Statement: $z0 = interfaceinvoke r1.<java.util.Map: boolean containsKey(java.lang.Object)>(r2) 
 ; Statement: if $z0 != 0 goto virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("...") 
(assert (not (not (= (ite var188 1 0) 0)))) ; Negate: Cond: $z0 != 0  
;(assert (var1072_put/1464166817 var37 (cast-from-__Array__Int__var2699__-to-var2699 var3698) null-var2699)) ; Statement: interfaceinvoke r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r2, null) 

(declare-const var37!1 var1072)
(declare-const var3698!1 (Array Int var2699))
(declare-const var146 var2304)
(define-const var3024 Int (getLength-Arr-var2699-1 var3698!1)) ; Statement: i0 = lengthof r2 
(define-const var3162 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto interfaceinvoke r1.<java.util.Map: java.lang.Object remove(java.lang.Object)>(r2) 
(assert (>= var3162 var3024)) ; Cond: i2 >= i0 
;(assert (var1072_remove/-1201052315 var37!1 (cast-from-__Array__Int__var2699__-to-var2699 var3698!1))) ; Statement: interfaceinvoke r1.<java.util.Map: java.lang.Object remove(java.lang.Object)>(r2) 

(declare-const var37!2 var1072)
(declare-const var3698!2 (Array Int var2699))
 ; Statement: goto [?= virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93)] 
(assert true) ; Non Conditional
(assert true)
;(assert (append/-1166366385 var3778!1 93)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93) 
(declare-const var3778!2 String)
(assert (str.prefixof var3778!1 var3778!2))
 ; Statement: return 
(check-sat)
; {append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var1072_containsKey/1715618542=([java.util.Map, java.lang.Object], boolean), cast-from-__Array__Int__var2699__-to-var2699=([java.lang.Object[]], java.lang.Object), var1072_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), getLength-Arr-var2699-1=([java.lang.Object[]], int), var1072_remove/-1201052315=([java.util.Map, java.lang.Object], java.lang.Object)}
; {var3778=r0, var2699=java.lang.Object, var3698=r2, var1072=java.util.Map, var37=r1, var188=$z0, var146=null, var2304=null_type, var3024=i0, var3162=i2}
; {r0=var3778, java.lang.Object=var2699, r2=var3698, java.util.Map=var1072, r1=var37, $z0=var188, null=var146, null_type=var2304, i0=var3024, i2=var3162}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2}
;stmts r0 := @parameter0: java.lang.StringBuilder;	r2 := @parameter1: java.lang.Object[];	r1 := @parameter2: java.util.Map;	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(91);	$z0 = interfaceinvoke r1.<java.util.Map: boolean containsKey(java.lang.Object)>(r2);	if $z0 != 0 goto virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("...");	interfaceinvoke r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r2, null);	i0 = lengthof r2;	i2 = 0;	if i2 >= i0 goto interfaceinvoke r1.<java.util.Map: java.lang.Object remove(java.lang.Object)>(r2);	interfaceinvoke r1.<java.util.Map: java.lang.Object remove(java.lang.Object)>(r2);	goto [?= virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93)];	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93);	return
;block_num 5