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

(declare-sort var2894 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-const null-String String)
(declare-const var148 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var148 null-String)))
(assert (not (and true (and (>= 2 0) (>= (str.len var148) 2)))))
(check-sat)
; {substring/850833817=([java.lang.String, int], java.lang.String)}
; {var148=r0, var2894=null_type, var102=$r1, var3219=r2, var2594=i1, var2682=$i0}
; {r0=var148, null_type=var2894, $r1=var102, r2=var3219, i1=var2594, $i0=var2682}
;seq <java.lang.String: java.lang.String substring(int)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(2);	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	i1 = 0;	$i0 = lengthof r2;	if i1 >= $i0 goto return r2;	return r2
;block_num 3