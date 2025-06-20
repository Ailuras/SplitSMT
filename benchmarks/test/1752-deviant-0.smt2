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

(declare-sort var3693 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(declare-const null-String String)
(declare-const var856 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var856 null-String)))
(assert true)
(define-const var3093 Int (length/-134980193 var856)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var2323 Int (- var3093 4)) ; Statement: $i1 = $i0 - 4 
(assert (not (and true (and (>= 0 0) (>= (str.len var856) var2323) (>= var2323 0)))))
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), lastIndexOf/-1292097097=([java.lang.String, int], int), indexOf/-1209756239=([java.lang.String, java.lang.String], int)}
; {var856=r0, var3693=null_type, var3093=$i0, var2323=$i1, var968=r1, var1191=i7, var647=$i6, var1105=$i8}
; {r0=var856, null_type=var3693, $i0=var3093, $i1=var2323, r1=var968, i7=var1191, $i6=var647, $i8=var1105}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: int lastIndexOf(int)>;	<java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 2,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.String: int indexOf(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	$i1 = $i0 - 4;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, $i1);	i7 = virtualinvoke r1.<java.lang.String: int lastIndexOf(int)>(47);	if i7 < 0 goto $i6 = virtualinvoke r1.<java.lang.String: int indexOf(java.lang.String)>("-");	$i6 = virtualinvoke r1.<java.lang.String: int indexOf(java.lang.String)>("-");	if $i6 < 0 goto $i8 = virtualinvoke r1.<java.lang.String: int length()>();	$i8 = virtualinvoke r1.<java.lang.String: int length()>();	if $i8 <= 0 goto return r1;	return r1
;block_num 4