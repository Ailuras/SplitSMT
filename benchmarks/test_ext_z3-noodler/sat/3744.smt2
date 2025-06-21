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

(declare-sort var15 0)
(declare-sort var3082 0)
(declare-sort var3013 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun getPort/20614931 (var15) Int)
(declare-fun urlAddress/1606454354 (var15) var3013)
(declare-fun setAddress/-1596111687 (var3013 String Int) var3013)
(declare-fun returnURL/2053574874 (var15 var3013) var15)
(declare-const null-var15 var15)
(declare-const null-String String)
(declare-const null-var3013 var3013)
(declare-const var101 var15) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var101 null-var15)))
(declare-const var3914 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3914 null-String)))
(assert true)
(define-const var1257 Int (lastIndexOf/-1292097097 var3914 58)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(58) 
(assert true)
(define-const var3338 Int (getPort/20614931 var101)) ; Statement: i2 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>() 
 ; Statement: if i0 < 0 goto r11 = r0 
(assert (< var1257 0)) ; Cond: i0 < 0 
(define-const var1067 String var3914) ; Statement: r11 = r0 
(assert true) ; Non Conditional
(define-const var2703 var3013 (urlAddress/1606454354 var101)) ; Statement: $r2 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress> 
 ; Statement: if $r2 != null goto $r3 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress> 
(assert (not (= var2703 null-var3013))) ; Cond: $r2 != null 
(define-const var80 var3013 (urlAddress/1606454354 var101)) ; Statement: $r3 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress> 
(assert true)
(define-const var1579 var3013 (setAddress/-1596111687 var80 var1067 var3338)) ; Statement: r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLAddress: org.apache.dubbo.common.url.component.URLAddress setAddress(java.lang.String,int)>(r11, i2) 
(assert true)
(define-const var1293 var15 (returnURL/2053574874 var101 var1579)) ; Statement: $r5 = specialinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL returnURL(org.apache.dubbo.common.url.component.URLAddress)>(r4) 
 ; Statement: return $r5 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), getPort/20614931=([org.apache.dubbo.common.URL], int), urlAddress/1606454354=([org.apache.dubbo.common.URL], org.apache.dubbo.common.url.component.URLAddress), setAddress/-1596111687=([org.apache.dubbo.common.url.component.URLAddress, java.lang.String, int], org.apache.dubbo.common.url.component.URLAddress), returnURL/2053574874=([org.apache.dubbo.common.URL, org.apache.dubbo.common.url.component.URLAddress], org.apache.dubbo.common.URL)}
; {var15=org.apache.dubbo.common.URL, var101=r1, var3914=r0, var3082=null_type, var1257=i0, var3338=i2, var1067=r11, var3013=org.apache.dubbo.common.url.component.URLAddress, var2703=$r2, var80=$r3, var1579=r4, var1293=$r5}
; {org.apache.dubbo.common.URL=var15, r1=var101, r0=var3914, null_type=var3082, i0=var1257, i2=var3338, r11=var1067, org.apache.dubbo.common.url.component.URLAddress=var3013, $r2=var2703, $r3=var80, r4=var1579, $r5=var1293}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(58);	i2 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>();	if i0 < 0 goto r11 = r0;	r11 = r0;	$r2 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>;	if $r2 != null goto $r3 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>;	$r3 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>;	r4 = virtualinvoke $r3.<org.apache.dubbo.common.url.component.URLAddress: org.apache.dubbo.common.url.component.URLAddress setAddress(java.lang.String,int)>(r11, i2);	$r5 = specialinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL returnURL(org.apache.dubbo.common.url.component.URLAddress)>(r4);	return $r5
;block_num 4