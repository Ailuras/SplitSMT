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

(declare-sort var1137 0)
(declare-sort var2170 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun port/1139202793 (var1137) Int)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-fun host/1139202793 (var1137) String)
(declare-const null-var1137 var1137)
(declare-const null-String String)
(declare-const var246 var1137) ; Statement: r1 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var246 null-var1137)))
(declare-const var2195 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2195 null-String)))
(assert true)
(define-const var618 Int (lastIndexOf/-1292097097 var2195 58)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(58) 
(define-const var2202 Int (port/1139202793 var246)) ; Statement: i2 = r1.<org.apache.dubbo.common.URLBuilder: int port> 
 ; Statement: if i0 < 0 goto r3 = r0 
(assert (not (< var618 0))) ; Negate: Cond: i0 < 0  
(assert (not (and true (and (>= 0 0) (>= (str.len var2195) var618) (>= var618 0)))))
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), port/1139202793=([org.apache.dubbo.common.URLBuilder], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String), Int_parseInt/1370970945=([java.lang.String], int), host/1139202793=([org.apache.dubbo.common.URLBuilder], java.lang.String)}
; {var1137=org.apache.dubbo.common.URLBuilder, var246=r1, var2195=r0, var2170=null_type, var618=i0, var2202=i2, var580=r3, var1687=$i1, var2466=$r2}
; {org.apache.dubbo.common.URLBuilder=var1137, r1=var246, r0=var2195, null_type=var2170, i0=var618, i2=var2202, r3=var580, $i1=var1687, $r2=var2466}
;seq <java.lang.String: int lastIndexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URLBuilder;	r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(58);	i2 = r1.<org.apache.dubbo.common.URLBuilder: int port>;	if i0 < 0 goto r3 = r0;	r3 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$i1 = i0 + 1;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1);	i2 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r2);	goto [?= r1.<org.apache.dubbo.common.URLBuilder: java.lang.String host> = r3];	r1.<org.apache.dubbo.common.URLBuilder: java.lang.String host> = r3;	r1.<org.apache.dubbo.common.URLBuilder: int port> = i2;	return r1
;block_num 3