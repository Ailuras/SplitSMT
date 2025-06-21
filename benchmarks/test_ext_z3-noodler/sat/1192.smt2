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

(declare-sort var2499 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-const null-String String)
(declare-const var2067 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2067 null-String)))
(assert true)
(define-const var2073 Int (indexOf/-1209756239 var2067 "/")) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("/") 
(assert true)
(define-const var729 Int (indexOf/-1209756239 var2067 ":")) ; Statement: i1 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":") 
(define-const var1969 Int (cast-from-Int-to-Int -1)) ; Statement: $i6 = (int) -1 
 ; Statement: if i0 != $i6 goto $i2 = i0 + 1 
(assert (not (= var2073 var1969))) ; Cond: i0 != $i6 
(define-const var3890 Int (+ var2073 1)) ; Statement: $i2 = i0 + 1 
(assert true) ; Non Conditional
(define-const var3873 Int var3890) ; Statement: i3 = $i2 
(define-const var1405 Int (cast-from-Int-to-Int -1)) ; Statement: $i8 = (int) -1 
 ; Statement: if i1 != $i8 goto $i4 = i1 
(assert (not (not (= var729 var1405)))) ; Negate: Cond: i1 != $i8  
(assert true)
(define-const var3341 Int (length/-134980193 var2067)) ; Statement: $i4 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: goto [?= $r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i3, $i4)] 
(assert true) ; Non Conditional
(assert (and true (and (>= var3873 0) (>= (str.len var2067) var3341) (>= var3341 var3873))))
(define-const var1793 String (substring/-1240304868 var2067 var3873 var3341)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i3, $i4) 
 ; Statement: return $r1 
(check-sat)
; {indexOf/-1209756239=([java.lang.String, java.lang.String], int), cast-from-Int-to-Int=([int], int), length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String)}
; {var2067=r0, var2499=null_type, var2073=i0, var729=i1, var1969=$i6, var3890=$i2, var3873=i3, var1405=$i8, var3341=$i4, var1793=$r1}
; {r0=var2067, null_type=var2499, i0=var2073, i1=var729, $i6=var1969, $i2=var3890, i3=var3873, $i8=var1405, $i4=var3341, $r1=var1793}
;seq <java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>
;cnt {"<java.lang.String: int indexOf(java.lang.String)>": 2,"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("/");	i1 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":");	$i6 = (int) -1;	if i0 != $i6 goto $i2 = i0 + 1;	$i2 = i0 + 1;	i3 = $i2;	$i8 = (int) -1;	if i1 != $i8 goto $i4 = i1;	$i4 = virtualinvoke r0.<java.lang.String: int length()>();	goto [?= $r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i3, $i4)];	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i3, $i4);	return $r1
;block_num 5