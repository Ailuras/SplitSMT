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

(declare-sort var1613 0)
(declare-sort var3253 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-fun var3253-init () var3253)
(declare-fun <init>/481518073 (var3253 String Int) void)
(declare-const null-String String)
(declare-const var2881 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2881 null-String)))
(assert true)
(define-const var818 Int (indexOf/-1037706067 var2881 58)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(58) 
(define-const var3576 Int (cast-from-Int-to-Int -1)) ; Statement: $i4 = (int) -1 
 ; Statement: if i0 <= $i4 goto r3 = r0 
(assert (not (<= var818 var3576))) ; Negate: Cond: i0 <= $i4  
(assert (and true (and (>= 0 0) (>= (str.len var2881) var818) (>= var818 0))))
(define-const var3304 String (substring/-1240304868 var2881 0 var818)) ; Statement: r3 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0) 
(define-const var2124 Int (+ var818 1)) ; Statement: $i1 = i0 + 1 
(assert (not (and true (and (>= var2124 0) (>= (str.len var2881) var2124)))))
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String), Int_parseInt/1370970945=([java.lang.String], int), var3253-init=([], java.net.InetSocketAddress), <init>/481518073=([java.net.InetSocketAddress, java.lang.String, int], void)}
; {var2881=r0, var1613=null_type, var818=i0, var3576=$i4, var3304=r3, var2124=$i1, var3062=$r2, var629=i2, var3253=java.net.InetSocketAddress, var1422=$r4}
; {r0=var2881, null_type=var1613, i0=var818, $i4=var3576, r3=var3304, $i1=var2124, $r2=var3062, i2=var629, java.net.InetSocketAddress=var3253, $r4=var1422}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(58);	$i4 = (int) -1;	if i0 <= $i4 goto r3 = r0;	r3 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$i1 = i0 + 1;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1);	i2 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r2);	goto [?= $r4 = new java.net.InetSocketAddress];	$r4 = new java.net.InetSocketAddress;	specialinvoke $r4.<java.net.InetSocketAddress: void <init>(java.lang.String,int)>(r3, i2);	return $r4
;block_num 3