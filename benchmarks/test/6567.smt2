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

(declare-sort var1442 0)
(declare-sort var45 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var45_isNumber/1050655655 (String) Bool)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-const null-String String)
(declare-const var1955 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1955 null-String)))
(assert true)
(define-const var198 Int (indexOf/-1037706067 var1955 46)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(46) 
 ; Statement: if i0 <= 0 goto return 0 
(assert (not (<= var198 0))) ; Negate: Cond: i0 <= 0  
(assert (and true (and (>= 0 0) (>= (str.len var1955) var198) (>= var198 0))))
(define-const var2031 String (substring/-1240304868 var1955 0 var198)) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0) 
(define-const var1011 Bool (var45_isNumber/1050655655 var2031)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto return 0 
(assert (not (= (ite var1011 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1552 Int (Int_parseInt/1370970945 var2031)) ; Statement: i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r1) 
 ; Statement: if i1 < 224 goto $z1 = 0 
(assert (not (< var1552 224))) ; Negate: Cond: i1 < 224  
 ; Statement: if i1 > 239 goto $z1 = 0 
(assert (> var1552 239)) ; Cond: i1 > 239 
(define-const var189 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var45_isNumber/1050655655=([java.lang.String], boolean), Int_parseInt/1370970945=([java.lang.String], int)}
; {var1955=r0, var1442=null_type, var198=i0, var2031=r1, var45=org.apache.dubbo.common.utils.StringUtils, var1011=$z0, var1552=i1, var189=$z1}
; {r0=var1955, null_type=var1442, i0=var198, r1=var2031, org.apache.dubbo.common.utils.StringUtils=var45, $z0=var1011, i1=var1552, $z1=var189}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(46);	if i0 <= 0 goto return 0;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r1);	if $z0 == 0 goto return 0;	i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r1);	if i1 < 224 goto $z1 = 0;	if i1 > 239 goto $z1 = 0;	$z1 = 0;	return $z1
;block_num 6