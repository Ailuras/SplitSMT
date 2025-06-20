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

(declare-sort var3911 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var260 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var260 null-String)))
(declare-const var3666 Bool) ; Statement: z2 := @parameter1: boolean 
(assert (not (= var3666 null-Bool)))
(define-const var2848 (Array Int String) arr-String-init) ; Statement: r0 = newarray (java.lang.String)[2] 
(assert true)
(define-const var2268 Bool (startsWith/-1785782452 var260 "[")) ; Statement: $z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("[") 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("[") 
(assert (not (= (ite var2268 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var1150 Bool (contains/1009244746 var260 (cast-from-String-to-String "]:"))) ; Statement: $z5 = virtualinvoke r1.<java.lang.String: boolean contains(java.lang.CharSequence)>("]:") 
 ; Statement: if $z5 == 0 goto $z1 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("[") 
(assert (not (= (ite var1150 1 0) 0))) ; Negate: Cond: $z5 == 0  
(assert true)
(define-const var1621 Int (indexOf/-1209756239 var260 "]:")) ; Statement: i4 = virtualinvoke r1.<java.lang.String: int indexOf(java.lang.String)>("]:") 
(assert (not (and true (and (>= 1 0) (>= (str.len var260) var1621) (>= var1621 1)))))
(check-sat)
; {arr-String-init=([], java.lang.String[]), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), indexOf/-1209756239=([java.lang.String, java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String)}
; {var260=r1, var3911=null_type, var3666=z2, var2848=r0, var2268=$z0, var1150=$z5, var1621=i4, var3750=$r5, var3402=$i3, var982=$r6}
; {r1=var260, null_type=var3911, z2=var3666, r0=var2848, $z0=var2268, $z5=var1150, i4=var1621, $r5=var3750, $i3=var3402, $r6=var982}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: boolean contains(java.lang.CharSequence)>;	<java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1,"<java.lang.String: int indexOf(java.lang.String)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r1 := @parameter0: java.lang.String;	z2 := @parameter1: boolean;	r0 = newarray (java.lang.String)[2];	$z0 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("[");	if $z0 == 0 goto $z1 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("[");	$z5 = virtualinvoke r1.<java.lang.String: boolean contains(java.lang.CharSequence)>("]:");	if $z5 == 0 goto $z1 = virtualinvoke r1.<java.lang.String: boolean startsWith(java.lang.String)>("[");	i4 = virtualinvoke r1.<java.lang.String: int indexOf(java.lang.String)>("]:");	$r5 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int,int)>(1, i4);	r0[0] = $r5;	$i3 = i4 + 2;	$r6 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int)>($i3);	r0[1] = $r6;	return r0
;block_num 3