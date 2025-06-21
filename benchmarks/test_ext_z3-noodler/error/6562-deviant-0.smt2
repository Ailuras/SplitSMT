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

(declare-sort var804 0)
(declare-sort var2941 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var2941_isNumber/1050655655 (String) Bool)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-const null-String String)
(declare-const var3883 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3883 null-String)))
(assert true)
(define-const var1753 Int (indexOf/-1037706067 var3883 46)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(46) 
 ; Statement: if i0 <= 0 goto return 0 
(assert (not (<= var1753 0))) ; Negate: Cond: i0 <= 0  
(assert (not (and true (and (>= 0 0) (>= (str.len var3883) var1753) (>= var1753 0)))))
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var2941_isNumber/1050655655=([java.lang.String], boolean), Int_parseInt/1370970945=([java.lang.String], int)}
; {var3883=r0, var804=null_type, var1753=i0, var110=r1, var2941=org.apache.dubbo.common.utils.StringUtils, var136=$z0, var2860=i1, var2381=$z1}
; {r0=var3883, null_type=var804, i0=var1753, r1=var110, org.apache.dubbo.common.utils.StringUtils=var2941, $z0=var136, i1=var2860, $z1=var2381}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(46);	if i0 <= 0 goto return 0;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r1);	if $z0 == 0 goto return 0;	i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r1);	if i1 < 224 goto $z1 = 0;	if i1 > 239 goto $z1 = 0;	$z1 = 1;	goto [?= return $z1];	return $z1
;block_num 6