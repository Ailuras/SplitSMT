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

(declare-sort var1860 0)
(declare-sort var157 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var157_isNumber/1050655655 (String) Bool)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-const null-String String)
(declare-const var576 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var576 null-String)))
(assert true)
(define-const var1804 Int (indexOf/-1037706067 var576 46)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(46) 
 ; Statement: if i0 <= 0 goto return 0 
(assert (not (<= var1804 0))) ; Negate: Cond: i0 <= 0  
(assert (not (and true (and (>= 0 0) (>= (str.len var576) var1804) (>= var1804 0)))))
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var157_isNumber/1050655655=([java.lang.String], boolean), Int_parseInt/1370970945=([java.lang.String], int)}
; {var576=r0, var1860=null_type, var1804=i0, var543=r1, var157=org.apache.dubbo.common.utils.StringUtils, var788=$z0, var1183=i1, var3175=$z1}
; {r0=var576, null_type=var1860, i0=var1804, r1=var543, org.apache.dubbo.common.utils.StringUtils=var157, $z0=var788, i1=var1183, $z1=var3175}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(46);	if i0 <= 0 goto return 0;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r1);	if $z0 == 0 goto return 0;	i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r1);	if i1 < 224 goto $z1 = 0;	$z1 = 0;	return $z1
;block_num 5