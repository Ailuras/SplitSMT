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

(declare-sort var487 0)
(declare-sort var843 0)
(declare-sort var2914 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun getPort/20614931 (var487) Int)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-fun urlAddress/1606454354 (var487) var2914)
(declare-fun setAddress/-1596111687 (var2914 String Int) var2914)
(declare-fun returnURL/2053574874 (var487 var2914) var487)
(declare-const null-var487 var487)
(declare-const null-String String)
(declare-const null-var2914 var2914)
(declare-const var994 var487) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var994 null-var487)))
(declare-const var1497 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1497 null-String)))
(assert true)
(define-const var1085 Int (lastIndexOf/-1292097097 var1497 58)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(58) 
(assert true)
(define-const var1733 Int (getPort/20614931 var994)) ; Statement: i2 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>() 
 ; Statement: if i0 < 0 goto r11 = r0 
(assert (not (< var1085 0))) ; Negate: Cond: i0 < 0  
(assert (not (and true (and (>= 0 0) (>= (str.len var1497) var1085) (>= var1085 0)))))
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), getPort/20614931=([org.apache.dubbo.common.URL], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String), Int_parseInt/1370970945=([java.lang.String], int), urlAddress/1606454354=([org.apache.dubbo.common.URL], org.apache.dubbo.common.url.component.URLAddress), setAddress/-1596111687=([org.apache.dubbo.common.url.component.URLAddress, java.lang.String, int], org.apache.dubbo.common.url.component.URLAddress), returnURL/2053574874=([org.apache.dubbo.common.URL, org.apache.dubbo.common.url.component.URLAddress], org.apache.dubbo.common.URL)}
; {var487=org.apache.dubbo.common.URL, var994=r1, var1497=r0, var843=null_type, var1085=i0, var1733=i2, var3878=r11, var450=$i1, var461=$r10, var2914=org.apache.dubbo.common.url.component.URLAddress, var953=$r2, var1376=$r3, var987=r4, var2487=$r5}
; {org.apache.dubbo.common.URL=var487, r1=var994, r0=var1497, null_type=var843, i0=var1085, i2=var1733, r11=var3878, $i1=var450, $r10=var461, org.apache.dubbo.common.url.component.URLAddress=var2914, $r2=var953, $r3=var1376, r4=var987, $r5=var2487}
;seq <java.lang.String: int lastIndexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(58);	i2 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>();	if i0 < 0 goto r11 = r0;	r11 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$i1 = i0 + 1;	$r10 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1);	i2 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r10);	goto [?= $r2 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>];	$r2 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>;	if $r2 != null goto $r3 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>;	$r3 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>;	r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLAddress: org.apache.dubbo.common.url.component.URLAddress setAddress(java.lang.String,int)>(r11, i2);	$r5 = specialinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL returnURL(org.apache.dubbo.common.url.component.URLAddress)>(r4);	return $r5
;block_num 4