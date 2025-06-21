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

(declare-sort var277 0)
(declare-sort var2449 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2449-init () var2449)
(declare-fun <init>/1191963135 (var2449 String) void)
(declare-fun addParam/-1258743626 (var2449 String String) void)
(declare-fun toString/1291819953 (var2449) String)
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-const null-String String)
(declare-const var1265 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1265 null-String)))
(define-const var666 var2449 var2449-init) ; Statement: $r0 = new io.netty.handler.codec.http.QueryStringEncoder 
(assert true)
;(assert (<init>/1191963135 var666 "")) ; Statement: specialinvoke $r0.<io.netty.handler.codec.http.QueryStringEncoder: void <init>(java.lang.String)>("") 

(declare-const var666!1 var2449)
(declare-const var358 String)
(assert true)
;(assert (addParam/-1258743626 var666!1 "" var1265)) ; Statement: virtualinvoke $r0.<io.netty.handler.codec.http.QueryStringEncoder: void addParam(java.lang.String,java.lang.String)>("", r1) 

(declare-const var666!2 var2449)
(declare-const var358!1 String)
(declare-const var1265!1 String)
(assert true)
(define-const var3766 String (toString/1291819953 var666!2)) ; Statement: $r2 = virtualinvoke $r0.<io.netty.handler.codec.http.QueryStringEncoder: java.lang.String toString()>() 
(assert (not (and true (and (>= 2 0) (>= (str.len var3766) 2)))))
(check-sat)
; {var2449-init=([], io.netty.handler.codec.http.QueryStringEncoder), <init>/1191963135=([io.netty.handler.codec.http.QueryStringEncoder, java.lang.String], void), addParam/-1258743626=([io.netty.handler.codec.http.QueryStringEncoder, java.lang.String, java.lang.String], void), toString/1291819953=([io.netty.handler.codec.http.QueryStringEncoder], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String)}
; {var1265=r1, var277=null_type, var2449=io.netty.handler.codec.http.QueryStringEncoder, var666=$r0, var358="", var3766=$r2, var146=$r3}
; {r1=var1265, null_type=var277, io.netty.handler.codec.http.QueryStringEncoder=var2449, $r0=var666, ""=var358, $r2=var3766, $r3=var146}
;seq <io.netty.handler.codec.http.QueryStringEncoder: java.lang.String toString()>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r0 = new io.netty.handler.codec.http.QueryStringEncoder;	specialinvoke $r0.<io.netty.handler.codec.http.QueryStringEncoder: void <init>(java.lang.String)>("");	virtualinvoke $r0.<io.netty.handler.codec.http.QueryStringEncoder: void addParam(java.lang.String,java.lang.String)>("", r1);	$r2 = virtualinvoke $r0.<io.netty.handler.codec.http.QueryStringEncoder: java.lang.String toString()>();	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String substring(int)>(2);	return $r3
;block_num 1