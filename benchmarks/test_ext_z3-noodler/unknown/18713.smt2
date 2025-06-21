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

(declare-sort var2276 0)
(declare-sort var1803 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun append/1183289509 (String Int) String)
(declare-fun var1803_containsKey/1715618542 (var1803 var2276) Bool)
(declare-fun cast-from-__Array__Int__var2276__-to-var2276 ((Array Int var2276)) var2276)
(define-fun append/1560614132 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-String String)
(declare-const null-__Array__Int__var2276__ (Array Int var2276))
(declare-const null-var1803 var1803)
(declare-const var363 String) ; Statement: r0 := @parameter0: java.lang.StringBuffer 
(assert (not (= var363 null-String)))
(declare-const var1194 (Array Int var2276)) ; Statement: r2 := @parameter1: java.lang.Object[] 
(assert (not (= var1194 null-__Array__Int__var2276__)))
(declare-const var839 var1803) ; Statement: r1 := @parameter2: java.util.Map 
(assert (not (= var839 null-var1803)))
(assert true)
;(assert (append/1183289509 var363 91)) ; Statement: virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(91) 

(declare-const var363!1 String)
(declare-const var2485 Int)
(define-const var1609 Bool (var1803_containsKey/1715618542 var839 (cast-from-__Array__Int__var2276__-to-var2276 var1194))) ; Statement: $z0 = interfaceinvoke r1.<java.util.Map: boolean containsKey(java.lang.Object)>(r2) 
 ; Statement: if $z0 != 0 goto virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>("...") 
(assert (not (= (ite var1609 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
;(assert (append/1560614132 var363!1 "...")) ; Statement: virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>("...") 
(declare-const var363!2 String)
(assert (str.prefixof var363!1 var363!2))
(assert true) ; Non Conditional
(assert true)
;(assert (append/1183289509 var363!2 93)) ; Statement: virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93) 

(declare-const var363!3 String)
(declare-const var953 Int)
 ; Statement: return 
(check-sat)
; {append/1183289509=([java.lang.StringBuffer, char], java.lang.StringBuffer), var1803_containsKey/1715618542=([java.util.Map, java.lang.Object], boolean), cast-from-__Array__Int__var2276__-to-var2276=([java.lang.Object[]], java.lang.Object), append/1560614132=([java.lang.StringBuffer, java.lang.String], java.lang.StringBuffer)}
; {var363=r0, var2276=java.lang.Object, var1194=r2, var1803=java.util.Map, var839=r1, var2485=91, var1609=$z0, var953=93}
; {r0=var363, java.lang.Object=var2276, r2=var1194, java.util.Map=var1803, r1=var839, 91=var2485, $z0=var1609, 93=var953}
;seq <java.lang.StringBuffer: java.lang.StringBuffer append(char)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(char)>
;cnt {"<java.lang.StringBuffer: java.lang.StringBuffer append(char)>": 2,"<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.StringBuffer;	r2 := @parameter1: java.lang.Object[];	r1 := @parameter2: java.util.Map;	virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(91);	$z0 = interfaceinvoke r1.<java.util.Map: boolean containsKey(java.lang.Object)>(r2);	if $z0 != 0 goto virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>("...");	virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(java.lang.String)>("...");	virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93);	return
;block_num 3